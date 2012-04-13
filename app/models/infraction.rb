require 'paperclip'

class Infraction < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :team
  belongs_to :offender, :class_name => 'Team'
  belongs_to :infraction_type
  belongs_to :status
  has_many :witnesses, :dependent => :destroy
  has_many :comments, :as => :commentable, :class_name => 'Post', :dependent => :destroy
  
  validates :game, :presence => true
  validates :team, :presence => true
  validates :offender, :presence => true
  validates :infraction_type, :presence => true
  validate :team_active
  #validates :witnesses, :length => { :minimum => 1 }, :unless => Proc.new { |infraction| infraction.photo? }
  
  scope :active, includes(:infraction_type).where(:game_id => Game.active.first, :infraction_types => { :active => true })
  scope :accepted, where(:status_id => Status.accepted)
  scope :pending, where(:status_id => Status.pending)
  
  #paperclip image:
  has_attached_file :photo,
    :styles => {
       :thumb => "50x50#",
       :small => "400x400>"
    }
  
  def check_status!
    # change status of the infraction to "accepted" if the number of witnesses is greater or equal than 1
    # change status of the infraction to "pending approval" if there are no witnesses at all
    self.status = self.witnesses.accepted.any? ? Status.accepted : Status.pending
    self.save if self.changed?
  end

  def team_active
    unless self.player.team.active?
      errors.add(:team_inactive, ", player must belong to an active team in order to create infractions.")
    end
  end
end
