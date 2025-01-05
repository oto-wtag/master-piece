class ArtistDetail < ApplicationRecord
  belongs_to :user

  validates :bio, length: { maximum: 1000 }, allow_blank: true
  validates :user_id, presense: true, uniqueness: true
end
