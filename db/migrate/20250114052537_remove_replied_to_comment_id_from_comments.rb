class RemoveRepliedToCommentIdFromComments < ActiveRecord::Migration[8.0]
  def change
    remove_column :comments, :replied_to_comment_id, :integer
  end
end
