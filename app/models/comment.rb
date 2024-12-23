class Comment < ApplicationRecord
  belongs_to :artwork
  belongs_to :user
  belongs_to :replied_to_comment, class_name: "Comment", optional: true, dependent: :destroy

  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :artwork_id, presence: true
  validates :user_id, presence: true
  validates :replied_to_comment_id, presence: true, if: :reply?

  private

  def reply?
    replied_to_comment.present?
  end
end
