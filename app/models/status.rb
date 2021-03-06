class Status < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  def to_s
    self.name
  end
  
  # overwriting method_missing to dinamically get statuses from the DB as methods
  def self.method_missing(method_id, *arguments, &block)
    status = Status.all.find {
      |status| status.name.to_s.underscore.start_with?(method_id.to_s)
    }
    status.nil? ? super : status
  end
end
