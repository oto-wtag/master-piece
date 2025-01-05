class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :profile_pic_url
      t.string :phone_number
      t.boolean :is_active
      t.string :role
      t.text :bio

      t.timestamps
    end
  end
end
