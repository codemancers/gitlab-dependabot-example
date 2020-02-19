# frozen_string_literal: true

class RepoController < ApplicationController
  include RepoHelper
  before_action :authenticate

  def index
    @projects, @pagination = get_projects_of_user(@current_user, params[:page])
  end
end
