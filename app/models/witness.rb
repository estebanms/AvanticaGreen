class DifferentTeamValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'cannot be part of the reporter team' if record.infraction.team == record.player.team
  end
end

class Witness < ActiveRecord::Base
  attr_accessible :player_id

  belongs_to :player
  belongs_to :infraction
  belongs_to :status
  
  validates :player, :presence => true, :different_team => true,
    :uniqueness => { :scope => :infraction_id, :message => 'is already a witness of this infraction.' }
  validates :infraction, :presence => true
  
  scope :accepted, -> { where(:status_id => Status.accepted) }
  scope :pending, -> { where(:status_id => Status.pending) }
  scope :rejected, -> {where(:status_id => Status.rejected) }

  after_save do
    # check if we need to change the status of the infraction to either accepted or "pending approval"
    infraction.check_status!
  end

  after_destroy do
    # check if we need to change the status of the infraction to "pending approval"
    infraction.check_status!
  end
end
