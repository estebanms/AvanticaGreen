class InfractionType < ActiveRecord::Base
  attr_accessible :name, :description, :active
  # might be useful for statistics
  has_many :infractions, :dependent => :restrict_with_exception
  
  validates :name, :presence => true, :uniqueness => true
  validates :points, :numericality => true, :allow_nil => true
  
  def to_s
    self.name
  end
end
