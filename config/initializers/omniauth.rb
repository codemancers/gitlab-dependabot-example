# frozen_string_literal: true

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :gitlab, ENV['GITLAB_KEY'], ENV['GITLAB_SECRET']
end
