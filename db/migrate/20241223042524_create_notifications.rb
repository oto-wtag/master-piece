class CreateNotifications < ActiveRecord::Migration[8.0]
  def change
    create_table :notifications do |t|
      t.references :users, null: false, foreign_key: true
      t.string :title
      t.text :message
      t.string :type
      t.boolean :is_read
      t.string :action_url

      t.timestamps
    end
  end
end
