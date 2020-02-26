# frozen_string_literal: true

class GitlabRepoService
  BASE_URL = 'https://gitlab.com/api/'
  PER_PAGE = 9
  API_VERSION = 'v4/'

  def initialize(user)
    @user_projects_endpoint = "users/#{user.gid}/projects"
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

  attr_reader :user_projects_endpoint, :headers
  def get_user_projects_url(page)
    uri = URI.join(BASE_URL, API_VERSION, user_projects_endpoint)
    uri.query = URI.encode_www_form(
      page: page,
      per_page: PER_PAGE
    )
    uri.to_s
  end
end
