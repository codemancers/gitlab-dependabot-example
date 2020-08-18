# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :user
  validates :name, presence: true
  validates :repo_id, presence: true
  validates :web_url, presence: true
  validates :user_id, presence: true
  validates :namespace_path, presence: true
  validates :visibility, presence: true, inclusion: { in: ['public'] }
  validates_associated :user
end
