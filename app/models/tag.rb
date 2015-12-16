class Tag < ActiveRecord::Base
  has_many :collections
  has_many :timestamps, class_name: "TagTime"

  def add_timestamp(stamp_id, stamp)
    timestamps << TagTime.create(timestamp: stamp, timestamp_id: stamp_id)
  end

  def find_closest_by_timestamp(stamp)
    timestamps.where("timestamp >= ?", stamp).order(timestamp: :asc).first if !timestamps.empty?
  end

end
