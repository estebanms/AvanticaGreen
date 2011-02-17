module SuggestionTypesHelper
  def suggestion_types_select(object = :suggestion, field_name = :post_type_id, options = {})
    collection_select(object, field_name, SuggestionType.all, :id, :name, options)
  end
end
