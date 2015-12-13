class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :url
      t.string :data
      t.integer :collection_id
      t.datetime :tag_time
      t.string :username
      t.integer :media_type

      t.timestamps null: false
    end

    add_index :posts,  :collection_id
  end
end
