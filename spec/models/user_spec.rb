# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it 'has valid factory' do
    expect(build(:user)).to be_valid
  end
end

RSpec.describe User, type: :model do
  %i[handle gid provider email fullname picture access_token].each do |attribute|
    it { should validate_presence_of(attribute) }
  end
end
