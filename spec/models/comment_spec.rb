require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validations" do
    it { is_expected.to validate_presence_of(:artwork) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:content) }
  end

  describe "associations" do
    it { is_expected.to belong_to(:artwork) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:replied_to_comment).class_name('Comment').optional }
  end
end
