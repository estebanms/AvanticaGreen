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

  scope :active, -> { includes(:infraction_type).where(:game_id => Game.active.first, :infraction_types => { :active => true }) }
  scope :accepted, -> { where(:status_id => Status.accepted) }
  scope :pending, -> { where(:status_id => Status.pending) }
  # will_paginate default page size
  self.per_page = 20

  PHOTO_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/pjepg', 'image/x-png']

  #paperclip image:
  has_attached_file :photo,
    :styles => {
       :thumb => "50x50#",
       :small => "400x400>"
    }
  validates_attachment_content_type :photo, :content_type => PHOTO_CONTENT_TYPES

  def check_status
    # change status of the infraction to "accepted" if the number of witnesses is greater or equal than 1,
    # or there is a photo attached as part of the infraction
    # change status of the infraction to "pending approval" if there are no witnesses at all
    self.status = (self.photo? or self.witnesses.accepted.any?) ? Status.accepted : Status.pending
  end

  def check_status!
    self.check_status
    self.save if self.changed?
  end

  def team_active
    unless self.player.team.active?
      errors.add(:team_inactive, ", player must belong to an active team in order to create infractions.")
    end
  end
end
