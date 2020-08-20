# frozen_string_literal: true

FactoryBot.define do
  factory :repository do
    scan { false }
    name { Faker::Name.name }
    description { Faker::Lorem.sentence }
    visibility { 'public' }
    repo_id { 'Faker::Number.number(digits: 5)' }
    web_url { 'https://github.com/faker-ruby/faker' }
    user { Faker::Number.number }
  end
end
