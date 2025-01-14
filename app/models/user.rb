class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one :artist_detail, dependent: :destroy
  has_many :artworks
  has_many :followers, foreign_key: :follower_user
  has_many :following, class_name: "Follower", foreign_key: :following_user
  has_many :likes
  has_many :comments
  has_many :notifications

  enum :role, { user: 0, artis: 1, admin: 2 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }

  def send_confirmation_instructions
    UserMailerJob.perform_later(self)
  end
end
