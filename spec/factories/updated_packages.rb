# frozen_string_literal: true

FactoryBot.define do
  factory :updated_package do
    name { 'random_package' }
    package_manager { 'bundler' }
    previous_version { '3.2.1' }
    current_version { '5.2.1' }
  end
end
