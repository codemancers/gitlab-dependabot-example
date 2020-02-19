# frozen_string_literal: true

module RepoHelper
  require 'rest-client'
  require 'json'

  def get_projects_of_user(user)
    puts(user)
    all_user_projects_url = "https://gitlab.com/api/v4/users/#{user.gid}/projects"
    headers = {
      'Accept' => "application/json",
      'Authorization' => "Bearer #{user.access_token}"
    }
    rsp = RestClient.get(all_user_projects_url, headers)
    JSON.parse(rsp)
  end
end