class CommentType < PostType
  # might be useful for statistics
  has_many :comments, :foreign_key => 'post_type_id', :dependent => :nullify
end
