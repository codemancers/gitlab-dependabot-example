class RepoController < ApplicationController
  include RepoHelper
  before_action :authenticate

  def index
    @projects = get_projects_of_user(@current_user)
  end
end