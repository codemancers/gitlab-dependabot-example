# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitlabRepoService, type: :service do
  it 'fetches list of Gitlab Projects' do
    user = build(:user)

    dummy_response_body = [
      {
        "id": 4,
        "description": nil,
        "default_branch": 'master',
        "ssh_url_to_repo": 'git@example.com:diaspora/diaspora-client.git',
        "http_url_to_repo": 'http://example.com/diaspora/diaspora-client.git',
        "web_url": 'http://example.com/diaspora/diaspora-client',
        "readme_url": 'http://example.com/diaspora/diaspora-client/blob/master/README.md',
        "tag_list": [
          'example',
          'disapora client'
        ],
        "name": 'Diaspora Client',
        "name_with_namespace": 'Diaspora / Diaspora Client',
        "path": 'diaspora-client',
        "path_with_namespace": 'diaspora/diaspora-client',
        "created_at": '2013-09-30T13:46:02Z',
        "last_activity_at": '2013-09-30T13:46:02Z',
        "forks_count": 0,
        "avatar_url": 'http://example.com/uploads/project/avatar/4/uploads/avatar.png',
        "star_count": 0
      }
    ].to_json

    dummy_response_headers = { x_next_page: '', x_prev_page: '', x_total_pages: '1', x_total: '1' }

    stub_request(:get, "https://gitlab.com/api/v4/users/#{user.gid}/projects?page=1&per_page=9")
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => "Bearer #{user.access_token}",
          'Host' => 'gitlab.com',
          # Match user-agent carefully as it can change according to the platform the tests run on
          'User-Agent' => /rest-client/
        }
      )
      .to_return(status: 200, body: dummy_response_body, headers: dummy_response_headers)

    projects_response = GitlabRepoService.new(user).fetch_user_projects(1)

    expect(projects_response.headers).to include(x_next_page: dummy_response_headers[:x_next_page])

    projects = JSON.parse(projects_response)

    expect(projects).not_to be_empty
  end
end
