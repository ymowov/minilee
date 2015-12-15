class Collection < ActiveRecord::Base
  has_many :posts
  has_many :timestamps, through: :tag
  belongs_to :tag

  validates :title, :start_date, :end_date, presence: true
end
