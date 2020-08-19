# frozen_string_literal: true

require 'dependabot/file_fetchers'
require 'dependabot/file_parsers'
require 'dependabot/update_checkers'
require 'dependabot/file_updaters'
require 'dependabot/pull_request_creator'
require 'dependabot/omnibus'
require 'gitlab'

class DependabotService
  attr_accessor :token, :repo_name, :credentials,
                :directory, :package_manager, :gitlab_hostname

  def initialize(token, repo_name)
    self.token = token
    self.repo_name = repo_name
    self.credentials = [
      {
        'type' => 'git_source',
        'host' => 'github.com',
        'username' => 'x-access-token',
        'password' => ENV['GITHUB_ACCESS_TOKEN'] # A GitHub access token with read access to public repos
      },
      {
        'type' => 'git_source',
        'host' => 'gitlab.com',
        'username' => 'x-access-token',
        'password' => token
      }
    ]
    self.directory = '/'
    self.package_manager = 'bundler'
    self.gitlab_hostname = 'gitlab.com'
  end

  def source(gitlab_hostname, repo_name, directory)
    Dependabot::Source.new(
      provider: 'gitlab',
      hostname: gitlab_hostname,
      api_endpoint: "https://#{gitlab_hostname}/api/v4",
      repo: repo_name,
      directory: directory,
      branch: nil
    )
  end

  def fetch_depedency_files(source, package_manager, repo_name, credentials)
    puts "Fetching #{package_manager} dependency files for #{repo_name}"
    fetcher = Dependabot::FileFetchers.for_package_manager(package_manager).new(
      source: source,
      credentials: credentials
    )
    fetcher
  end

  def parse_dependency_files(package_manager, files, source, credentials)
    puts 'Parsing dependencies information'
    parser = Dependabot::FileParsers.for_package_manager(package_manager).new(
      dependency_files: files,
      source: source,
      credentials: credentials
    )

    parser.parse
  end

  def get_update_details(package_manager, dep, files, credentials)
    Dependabot::UpdateCheckers.for_package_manager(package_manager).new(
      dependency: dep,
      dependency_files: files,
      credentials: credentials
    )
  end

  def requirements(checker)
    if !checker.requirements_unlocked_or_can_be?
      if checker.can_update?(requirements_to_unlock: :none) then :none
      else :update_not_possible
      end
    elsif checker.can_update?(requirements_to_unlock: :own) then :own
    elsif checker.can_update?(requirements_to_unlock: :all) then :all
    else :update_not_possible
    end
  end

  def generate_updated_dependency_files(dep, package_manager, updated_deps, files, credentials)
    print "  - Updating #{dep.name} (from #{dep.version})…"
    updater = Dependabot::FileUpdaters.for_package_manager(package_manager).new(
      dependencies: updated_deps,
      dependency_files: files,
      credentials: credentials
    )

    updater.updated_dependency_files
  end

  def submit_pr(source, commit, updated_deps, updated_files, credentials)
    pr_creator = Dependabot::PullRequestCreator.new(
      source: source,
      base_commit: commit,
      dependencies: updated_deps,
      files: updated_files,
      credentials: credentials,
      assignees: nil,
      label_language: true
    )
    pull_request = pr_creator.create
    puts 'submitted'
    pull_request
  end

  def run
    source_value = source(gitlab_hostname, repo_name, directory)
    fetcher = fetch_depedency_files(source_value, package_manager, repo_name, credentials)
    begin
      files = fetcher.files
      commit = fetcher.commit
    rescue NoMethodError => e
      puts e.message
      puts 'Repository might be empty'
      return
    end
    dependencies = parse_dependency_files(package_manager, files, source_value, credentials)
    dependencies.select(&:top_level?).each do |dep|
      checker = get_update_details(package_manager, dep, files, credentials)
      next if checker.up_to_date?

      requirements_to_unlock = requirements(checker)
      next if requirements_to_unlock == :update_not_possible

      updated_deps = checker.updated_dependencies(
        requirements_to_unlock: requirements_to_unlock
      )
      updated_files = generate_updated_dependency_files(dep, package_manager, updated_deps,
                                                        files, credentials)
      pull_request = submit_pr(source_value, commit, updated_deps, updated_files, credentials)
      next unless pull_request

      puts 'Done'
    end
  end
end
