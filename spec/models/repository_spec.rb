# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'validations' do
    %i[name visibility repo_id web_url].each do |attribute|
      it { should validate_presence_of(attribute) }
    end
  end

  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'visibility should be public' do
    it { should allow_value('public').for(:visibility) }
    it { should_not allow_value('private').for(:visibility) }
  end
end
