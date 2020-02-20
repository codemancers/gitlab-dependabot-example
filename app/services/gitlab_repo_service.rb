# frozen_string_literal: true

require 'rest-client'
require 'json'
require 'uri'

class GitlabRepoService
  def initialize(user)
    @base_url = 'https://gitlab.com/api/'
    @api_version = 'v4/'
    @user_projects_endpoint = "users/#{user.gid}/projects"
    @per_page = 9
    @headers = {
      'Accept' => 'application/json',
      'Authorization' => "Bearer #{user.access_token}"
    }
  end

  def fetch_user_projects(page)
    url = get_user_projects_url(page)
    RestClient.get(url, headers)
  end

  private

  attr_reader :base_url, :api_version, :user_projects_endpoint, :per_page, :headers
  def get_user_projects_url(page)
    uri = URI.join(base_url, api_version, user_projects_endpoint)
    uri.query = URI.encode_www_form(
      page: page,
      per_page: per_page
    )
    uri.to_s
  end
end
