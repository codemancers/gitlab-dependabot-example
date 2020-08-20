# frozen_string_literal: true

class ScansController < ApplicationController
  def index
    @repositories = Repository.where(scan: true)
  end

  def create
    @repositories = Repository.where(scan: true)
    @repositories.each do |repository|
      repository.updated_packages.delete_all
      access_token = repository.user.access_token
      namespace_path = repository.namespace_path
      updated_packages = dependabot_service(access_token, namespace_path)
      next unless updated_packages

      add_package_details(updated_packages, repository)
    end
    redirect_to scans_path
  end

  private

  def dependabot_service(token, path)
    DependabotService.new(token, path).run
  end

  def add_package_details(updated_packages, repository)
    updated_packages.each do |updated_package|
      updated_package.each do |package|
        repository.updated_packages.create(name: package.name,
                                           package_manager: package.package_manager,
                                           previous_version: package.previous_version,
                                           current_version: package.version)
      end
    end
  end
end
