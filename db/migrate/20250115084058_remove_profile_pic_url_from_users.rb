class RemoveProfilePicUrlFromUsers < ActiveRecord::Migration[8.0]
  def change
    remove_column :users, :profile_pic_url, :string
  end
end
