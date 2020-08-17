# frozen_string_literal: true

class ScansController < ApplicationController
  def index
    @repositories = Repository.where(scan: true)
  end

  def create
    @repositories = Repository.where(scan: true)
    @repositories.each do |repository|
      access_token = repository.user.access_token
      namespace_path = repository.namespace_path
      dependabot_service(access_token, namespace_path)
    end
    redirect_to scans_path
  end

  private

  def dependabot_service(token, path)
    DependabotService.new(token, path).run
  end
end
