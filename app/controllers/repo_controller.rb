# frozen_string_literal: true

class RepoController < ApplicationController
  before_action :authenticate

  def index
    projects_response = GitlabRepoService.new(@current_user).fetch_user_projects(params[:page])
    @projects = JSON.parse(projects_response).select { |project| project['visibility'] == 'public' }
    @pagination = paginate_repos_from_gitlab_response_headers(projects_response.headers)
  end
end
