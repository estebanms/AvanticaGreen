class Post < ActiveRecord::Base
  # TODO: It's not recomendable to have all fields accesible. This might need refactoring in order to make it more secure.
  attr_accessible :description, :post_type_id, :anonymous

  belongs_to :player
  
  validates :player, :presence => true
  validates :description, :presence => true
end
