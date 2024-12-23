require 'rails_helper'

RSpec.describe Follower, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:following_user) }
    it { is_expected.to validate_presence_of(:follower_user) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:following_user).class_name('User') }
    it { is_expected.to belong_to(:follower_user).class_name('User') }
  end
end
