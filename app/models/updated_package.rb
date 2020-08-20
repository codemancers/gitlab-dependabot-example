# frozen_string_literal: true

class UpdatedPackage < ApplicationRecord
  belongs_to :repository
  validates :name, presence: true
  validates :package_manager, presence: true
  validates :previous_version, presence: true
  validates :current_version, presence: true
end
