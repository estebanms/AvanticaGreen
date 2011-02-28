require 'paperclip'

class Infraction < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :team
  belongs_to :offender, :class_name => 'Team'
  belongs_to :infraction_type
  belongs_to :status
  has_many :witnesses, :dependent => :destroy
  has_many :comments, :class_name => 'Post'
  
  validates :game, :presence => true
  validates :team, :presence => true
  validates :offender, :presence => true
  validates :infraction_type, :presence => true
  #validates :witnesses, :length => { :minimum => 1 }, :if => Proc.new { |infraction| infraction.photo.nil? }
  
  #paperclip image:
  has_attached_file :photo,
    :styles => {
       :thumb => "50x50#",
       :small => "400x400>"
    }

  def reporter
    reporter_string = self.team.name
    reporter_string += " (#{self.player.full_name})" unless self.anonymous?
    reporter_string
  end

  def anonymous?
    self.player.nil?
  end
end
