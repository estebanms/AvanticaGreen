class Witness < ActiveRecord::Base
  belongs_to :player
  belongs_to :infraction
  belongs_to :status
  
  validates :player, :presence => true
  validates :infraction, :presence => true
  
  before_destroy do
    # TODO: change status of the infraction to "pending approval" if the number of witnesses is less than 1
  end
end
