class Tag < ActiveRecord::Base
  has_many :collections
  has_many :timestamps, class_name: "TagTime"

  def add_timestamp(stamp_id, stamp)
    timestamps << TagTime.create(timestamp: stamp, timestamp_id: stamp_id)
  end
end
