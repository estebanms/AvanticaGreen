class PostType < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  attr_accessible :name, :description 

 
  def to_s
    self.name
  end
end
