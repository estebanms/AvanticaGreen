class DifferentTeamValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'cannot be part of the reporter team' if record.infraction.team == record.player.team
  end
end

class Witness < ActiveRecord::Base
  belongs_to :player
  belongs_to :infraction
  belongs_to :status
  
  validates :player, :presence => true, :different_team => true
  validates :infraction, :presence => true
  
  before_destroy do
    # TODO: change status of the infraction to "pending approval" if the number of witnesses is less than 1
  end
end
