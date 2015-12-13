class Post < ActiveRecord::Base
  belongs_to :collection, foreign_key: :collection_id

  enum media_type: [:image, :video]
end
