class Suggestion < Post
  # TODO: It's not recomendable to have all fields accesible. This might need refactoring in order to make it more secure.
  attr_accessible :suggestion_type_id, :status_id, :suggestion

  belongs_to :suggestion_type, :foreign_key => 'post_type_id'
  belongs_to :status
  has_many :comments, :as => :commentable, :class_name => 'Post', :dependent => :destroy
end
