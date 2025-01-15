class Artwork < ApplicationRecord
  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy

  has_many :liking_users, through: :likes, source: :user

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 3, maximum: 255 }
  validates :description, presence: true
  validates :image, presence: true
end
