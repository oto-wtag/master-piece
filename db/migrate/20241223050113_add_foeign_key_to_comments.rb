class AddFoeignKeyToComments < ActiveRecord::Migration[8.0]
  def change
    add_foreign_key :comments, :comments, column: :replied_to_comment_id
  end
end
