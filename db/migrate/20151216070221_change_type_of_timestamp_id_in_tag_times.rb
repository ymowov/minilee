class ChangeTypeOfTimestampIdInTagTimes < ActiveRecord::Migration
  def change
    remove_column :tag_times,  :timestamp_id, :integer
    add_column :tag_times,  :timestamp_id, :string
  end
end
