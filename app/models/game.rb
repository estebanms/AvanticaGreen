class Game < ActiveRecord::Base
  has_many :infractions, :dependent => :restrict
  
  validates :start_date, :presence => true
end
