class CreateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :tags do |t|
      t.string :name, limit: 30
      t.string :permalink, limit: 255

      t.timestamps
    end

    add_index :tags, :permalink, unique: true
  end
end
