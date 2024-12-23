class User < ApplicationRecord
  has_one :artist_detail, dependent: :destroy
  has_many :artworks
  has_many :followers, foreign_key: :follower_user
  has_many :following, class_name: "Follower", foreign_key: :following_user
  has_many :likes
  has_many :comments
  has_many :notifications

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, on: :create

  enum role: { user: "user", artist: "artist", admin: "admin" }

  validates :role, inclusion: { in: roles.keys }
end
