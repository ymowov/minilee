class TagTime < ActiveRecord::Base
  belongs_to :tag, foreign_key: :tag_id

  scope :find_closest_by_timestamp, -> (stamp) { where("timestamp <= ?", stamp).order(timestamp: :desc).first }
end
