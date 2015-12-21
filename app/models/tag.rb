class Tag < ActiveRecord::Base
  has_many :collections
  has_many :timestamps, class_name: "TagTime"

  def add_timestamp(stamp_id, stamp)
    timestamps << TagTime.create(timestamp: stamp, timestamp_id: stamp_id)
  end

  def find_closest_by_timestamp(stamp)
    timestamps.where("timestamp >= ?", stamp).order(timestamp: :asc).first if !timestamps.empty?
  end

  def add_avg_samples(s1_id, s2_id)
    s1 = TagTime.find_by_timestamp_id(s1_id)
    s2 = TagTime.find_by_timestamp_id(s2_id)

    self.avg_time = 0 if avg_time.nil?

    if s1 && s2
      self.avg_time += get_difference_between(s1.timestamp, s2.timestamp)/2
      self.avg_time_calls = (self.avg_time_calls.to_i + get_difference_between(s1_id.to_i, s2_id.to_i)/2).to_s

      self.save
    end
  end

  def get_difference_between(s1, s2)
    s1, s2 = s2, s1 if s1 > s2 # swap
    # s2 > s1
    s2 - s1
  end
end