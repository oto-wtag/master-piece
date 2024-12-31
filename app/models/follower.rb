class Follower < ApplicationRecord
  belongs_to :following_user, class_name: "User"
  belongs_to :follower_user, class_name: "User"

  validates :follower_user_id, :following_user_id, presence: true
  validate :cannot_follow_self

  private

  def cannot_follow_self
    errors.add(:following_user_id, "You cannot follow yourself") if follower_user_id == following_user_id
  end
end
