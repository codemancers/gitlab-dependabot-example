# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :user
  validates_presence_of :scan, :name, :visibility, :repo_id, :web_url, :user_id
  validates :visibility, format: { with: /\Apublic\Z/ }
  validates_associated :user
end
