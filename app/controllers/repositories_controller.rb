# frozen_string_literal: true

class RepositoriesController < ApplicationController
  before_action :authenticate

  def index
    @repositories = Repository.all
    @pagination = paginate_repos_from_gitlab_response_headers(projects_response.headers)
  end

  def create
    projects = JSON.parse(projects_response).select { |project| project['visibility'] == 'public' }
    projects.each do |project|
      current_user.repositories.create(scan: false, name: project['name'], repo_id: project['id'],
                                       description: project['description'],
                                       visibility: project['visibility'],
                                       web_url: project['web_url'],
                                       namespace_path: project['path_with_namespace'])
    end
    redirect_to repositories_path
  end

  def update
    @repository = Repository.find(params[:id])
    if @repository['scan'] == true
      @repository.update_attribute(:scan, false)
    else
      @repository.update_attribute(:scan, true)
    end
    redirect_to repositories_path
  end

  private

  def projects_response
    GitlabRepoService.new(current_user).fetch_user_projects(params[:page])
  end
end
