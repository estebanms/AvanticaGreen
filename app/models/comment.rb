class Comment < Post
  belongs_to :infraction
  belongs_to :comment_type, :foreign_key => 'post_type_id'
  
  validates :infraction, :presence => true
end
