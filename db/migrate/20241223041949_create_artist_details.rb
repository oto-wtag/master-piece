class CreateArtistDetails < ActiveRecord::Migration[8.0]
  def change
    create_table :artist_details do |t|
      t.references :user, null: false, foreign_key: true
      t.string :instagram_link
      t.string :pinterest_link
      t.string :dribble_link
      t.string :behance_link
      t.string :etsy_link

      t.timestamps
    end
  end
end
