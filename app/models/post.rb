class Post < ActiveRecord::Base
  belongs_to :player
  
  # we're currently supporting anonymous posts, uncomment the following line if we don't want that
  #validates :player, :presence => true
  validates :description, :presence => true
end
