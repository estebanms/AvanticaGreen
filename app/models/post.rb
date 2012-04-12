class Post < ActiveRecord::Base
  belongs_to :player
  
  validates :player, :presence => true
  validates :description, :presence => true
end
