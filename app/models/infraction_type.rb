class InfractionType < ActiveRecord::Base
  # might be useful for statistics
  has_many :infractions, :dependent => :restrict
  
  validates :name, :presence => true, :uniqueness => true
  validates :points, :numericality => true, :allow_nil => true
  
  def to_s
    self.name
  end
end
