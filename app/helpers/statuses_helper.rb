module StatusesHelper
  def statuses_select(object, field_name = :status_id, options = {})
    collection_select(object, field_name, Status.all, :id, :name, options)
  end
end
