class InfractionType < ActiveRecord::Base
  # might be useful for statistics
  has_many :infractions, :dependent => :restrict
  
  validates :name, :presence => true, :uniqueness => true
  validates :points, :numericality => true
end
