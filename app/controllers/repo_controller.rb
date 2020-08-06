# frozen_string_literal: true

class RepoController < ApplicationController
  before_action :authenticate

  def index
    projects_response = GitlabRepoService.new(@current_user).fetch_user_projects(params[:page])
    projects = JSON.parse(projects_response).select { |project| project['visibility'] == 'public' }
    @user = User.find_by(gid: projects.first['owner']['id'])
    @repositories = @user.repositories
    if @repositories.empty? || @repositories.length != projects
      projects.each do |project|
        next if @user.repositories.find_by(repo_id: project['id'])

        @user.repositories.create(scan: false, name: project['name'], repo_id: project['id'],
                                  description: project['description'],
                                  visibility: project['visibility'],
                                  web_url: project['web_url'])
      end
      @repositories = @user.repositories
    end

    @pagination = paginate_repos_from_gitlab_response_headers(projects_response.headers)
  end

  def update
    @repository = Repository.find(params[:id])
    if @repository['scan'] == false
      @repository.update_attribute(:scan, true)
    elsif @repository['scan'] == true
      @repository.update_attribute(:scan, false)
    end
    redirect_to repositories_path
  end
end
