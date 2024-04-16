class DropCommentsAndCommentsArea < ActiveRecord::Migration[6.0]
  def change
    drop_table :comment_areas, force: :cascade
    drop_table :comments
  end
end
