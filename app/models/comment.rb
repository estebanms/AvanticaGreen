class Comment < Post
  belongs_to :commentable, :polymorphic => true
  belongs_to :comment_type, :foreign_key => 'post_type_id'
  
  validates :commentable, :presence => true
end
