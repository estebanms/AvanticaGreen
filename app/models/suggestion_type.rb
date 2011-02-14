class SuggestionType < PostType
  # might be useful for statistics
  has_many :suggestions, :foreign_key => 'post_type_id', :dependent => :nullify
end
