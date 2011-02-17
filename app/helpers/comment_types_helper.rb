module CommentTypesHelper
  def comment_types_select(object = :comment, field_name = :post_type_id, options = {})
    collection_select(object, field_name, CommentType.all, :id, :name, options)
  end
end
