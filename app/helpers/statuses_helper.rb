module StatusesHelper
  def statuses_select(object, field_name = :status_id, options = {})
    collection_select(object, field_name, Status.all, :id, :name, options)
  end
  
  def accepted?(object)
    status?(object, 'Accepted')
  end
  
  def rejected?(object)
    status?(object, 'Rejected')
  end
  
  def pending?(object)
    status?(object, 'Pending revision')
  end
  
  def closed?(object)
    status?(object, 'Closed')
  end

private
  def status?(object, status)
    object.status.name == status rescue false
  end
end
