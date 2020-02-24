# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GitlabRepoService, type: :service do
  it 'fetches list of Gitlab Projects' do
    stub_request(:get, 'https://gitlab.com/api/v4/users/51342660/projects?page=1&per_page=9')
      .with(
        headers: {
          'Accept' => 'application/json',
          'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
          'Authorization' => 'Bearer s3cr3t@acc3sst0k3n',
          'Host' => 'gitlab.com',
          'User-Agent' => 'rest-client/2.1.0 (darwin18.6.0 x86_64) ruby/2.7.0p0'
        }
      )
      .to_return(status: 200, body: '', headers: {})
  end
end
