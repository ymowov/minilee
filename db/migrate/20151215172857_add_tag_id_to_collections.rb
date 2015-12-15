class AddTagIdToCollections < ActiveRecord::Migration
  def change
    add_column :collections, :tag_id, :integer
    add_index :collections, :tag_id
  end
end
