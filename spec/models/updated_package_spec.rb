# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UpdatedPackage, type: :model do
  describe 'validations' do
    %i[name package_manager previous_version current_version].each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end
end
