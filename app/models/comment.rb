class Comment < ApplicationRecord
  belongs_to :artwork
  belongs_to :user
  validates :content, presence: true, length: { minimum: 1, maximum: 1000 }
  validates :artwork_id, :user_id, presence: true
end
