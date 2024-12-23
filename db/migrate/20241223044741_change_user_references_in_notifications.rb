class ChangeUserReferencesInNotifications < ActiveRecord::Migration[8.0]
  def change
    remove_reference :notifications, :users, index: true, foreign_key: true
    add_reference :notifications, :user, null: false, foreign_key: true
  end
end
