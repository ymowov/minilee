class CreateTagTimes < ActiveRecord::Migration
  def change
    create_table :tag_times do |t|
      t.integer :timestamp
      t.integer :timestamp_id
      t.integer :tag_id

      t.timestamps null: false
    end

    add_index :tag_times,  :tag_id
  end
end
