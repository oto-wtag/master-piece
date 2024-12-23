require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe "associations" do
    it { is_expected.to have_one(:artist_detail).dependent(:destroy) }
    it { is_expected.to have_many(:artworks) }
    it { is_expected.to have_many(:followers).class_name('Follower').with_foreign_key(:follower_user_id) }
    it { is_expected.to have_many(:following).class_name('Follower').with_foreign_key(:following_user_id) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:notifications) }
  end
end
