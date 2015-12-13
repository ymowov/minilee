class Collection < ActiveRecord::Base
  has_many :posts
  validates :title, :start_date, :end_date, presence: true
  # validate :validate_start_and_end_dates

  # def validate_start_and_end_dates
  #   binding.pry
  #   DateTime.parse(start_date) rescue errors.add(:start_date, 'must be a valid datetime')
  #   DateTime.parse(end_date) rescue errors.add(:end_date, 'must be a valid datetime')
  # end
end
