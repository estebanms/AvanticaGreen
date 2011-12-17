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
  
  scope :accepted, where(:status_id => Status.accepted)
  scope :pending, where(:status_id => Status.pending)
  scope :rejected, where(:status_id => Status.rejected)
  
  after_create do
    # change status of the infraction to "accepted" if the number of witnesses is greater or equal than 1
    if infraction.witnesses.accepted.any?
      infraction.status = Status.accepted
      infraction.save
    end
  end
  
  after_destroy do
    # change status of the infraction to "pending approval" if there are no witnesses left
    if infraction.witnesses.accepted.empty?
      infraction.status = Status.pending
      infraction.save
    end
  end
end
