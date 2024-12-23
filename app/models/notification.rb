class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"

  validates :recipient_id, presence: true
  validates :message, presence: true, length: { maximum: 500 }
end
