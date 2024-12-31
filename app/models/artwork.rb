class Artwork < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :title, presense: true, length: { minimum: 3, maximum: 255 }
  validates :image_url, :user_id, presense: true
end
