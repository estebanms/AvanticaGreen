class Suggestion < Post
  belongs_to :suggestion_type, :foreign_key => 'post_type_id'
  belongs_to :status
  has_many :comments, :as => :commentable, :class_name => 'Post', :dependent => :destroy
end
