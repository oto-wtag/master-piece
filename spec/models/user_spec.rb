# spec/models/user_spec.rb
require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe "associations" do
    it { is_expected.to have_one(:artist_detail).dependent(:destroy) }
    it { is_expected.to have_many(:artworks) }
    it { is_expected.to have_many(:followers).foreign_key(:follower_user) }
    it { is_expected.to have_many(:following).class_name('Follower').foreign_key(:following_user) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:notifications) }
  end
end