# frozen_string_literal: true

module RepoHelper
  require 'rest-client'
  require 'json'

  def get_projects_of_user(user, page)
    all_user_projects_url = "https://gitlab.com/api/v4/users/#{user.gid}"\
      "/projects?page=#{page}&per_page=9"
    headers = {
      'Accept' => "application/json",
      'Authorization' => "Bearer #{user.access_token}"
    }
    rsp = RestClient.get(all_user_projects_url, headers)
    pagination = {
      next: rsp.headers[:x_next_page],
      prev: rsp.headers[:x_prev_page],
      total_pages: rsp.headers[:x_total_pages],
      total: rsp.headers[:x_total],
      per_page: rsp.headers[:x_per_page]
    }
    projects = JSON.parse(rsp)
    return projects, pagination
  end
end