class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable

  has_one :artist_detail, dependent: :destroy
  has_many :artworks
  has_many :followers, foreign_key: :follower_user
  has_many :following, class_name: "Follower", foreign_key: :following_user
  has_many :followed_users, through: :following, source: :follower_user
  has_many :likes
  has_many :comments
  has_many :notifications
  has_one_attached :profile_photo
  has_many :liked_artworks, through: :likes, source: :artwork

  enum :role, { user: 0, artist: 1, admin: 2 }

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :name, presence: true, uniqueness: true, length: { minimum: 3, maximum: 50 }
  validates :profile_photo, content_type: [ "image/png", "image/jpg", "image/jpeg" ], size: { less_than: 5.megabytes, message: "is too large" }

  validates :phone_number, uniqueness: true, allow_blank: true, format: {
    with: /\A\+?\d{10,15}\z/,
    message: "must be a valid phone number (10-15 digits, optional + at start)"
  }, if: -> { phone_number.present? }

  def send_confirmation_instructions
    UserMailerJob.perform_later(self)
  end
end
