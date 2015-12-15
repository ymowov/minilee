class TagTime < ActiveRecord::Base
  belongs_to :tag, foreign_key: :tag_id
end
