class CreateArtworks < ActiveRecord::Migration[8.0]
  def change
    create_table :artworks do |t|
      t.references :users, null: false, foreign_key: true
      t.string :title
      t.text :description
      t.string :image_url
      t.boolean :is_active

      t.timestamps
    end
  end
end
