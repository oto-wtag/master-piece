class RemoveImageUrlFromArtworks < ActiveRecord::Migration[8.0]
  def change
    remove_column :artworks, :image_url, :string
  end
end
