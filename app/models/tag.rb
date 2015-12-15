class Tag < ActiveRecord::Base
  has_many :collections
  has_many :timestamps, class_name: "TagTime"
end
