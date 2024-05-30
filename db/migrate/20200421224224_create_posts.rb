class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.text :content
      t.string :content_type, limit: 40
      t.string :title, limit: 255
      t.text :summary
      t.string :permalink, limit: 255

      t.timestamps
    end

    add_index :posts, :permalink
  end
end
