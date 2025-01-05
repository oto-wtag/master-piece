class ChangeUserReferencesInArtworks < ActiveRecord::Migration[8.0]
  def change
    remove_reference :artworks, :users, index: true, foreign_key: true
    add_reference :artworks, :user, null: false, foreign_key: true
  end
end
