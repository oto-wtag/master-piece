require 'rails_helper'

RSpec.describe Notification, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:recipient) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:message) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:recipient).class_name('User') }
  end
end
