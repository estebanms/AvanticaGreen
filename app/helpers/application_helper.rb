module ApplicationHelper
  FLASH_TYPES = [
    :notice, 
    :message, 
    :warning, 
    :error
  ]
  
  def display_flash_messages(type = :all)
    flash_messages = Array.new
    flash_types = (type == :all) ? FLASH_TYPES : [type]
    flash_types.each do |flash_type|
      flash_messages << "<p id=\"#{flash_type}\">#{flash[flash_type]}</p>" if flash[flash_type]
    end
    return flash_messages.join('\n')
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
