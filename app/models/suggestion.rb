class Suggestion < Post
  belongs_to :suggestion_type, :foreign_key => 'post_type_id'
end
