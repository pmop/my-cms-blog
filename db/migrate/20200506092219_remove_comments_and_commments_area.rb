class RemoveCommentsAndCommmentsArea < ActiveRecord::Migration[6.0]
  def change
    remove_column :posts, :comment_area_id
  end
end
