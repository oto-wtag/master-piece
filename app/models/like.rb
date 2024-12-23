class Like < ApplicationRecord
  belongs_to :artwork
  belongs_to :user

  validates :user_id, presence: true, uniqueness: { scope: :artwork_id, message: "You can like an artwork only once" }
  validates :artwork_id, presence: true
end
