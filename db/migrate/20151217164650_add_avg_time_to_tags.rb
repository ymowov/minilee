class AddAvgTimeToTags < ActiveRecord::Migration
  def change
   add_column :tags, :avg_time, :integer, default: 0
   add_column :tags, :avg_time_calls, :string, default: 0
  end
end
