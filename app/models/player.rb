require 'paperclip'

class Player < ActiveRecord::Base
  # TODO: This should be reviewed since not all fields should be accessible
  attr_accessible :avatar, :name, :active, :last_names, :user_id, :team_id, :is_admin

  belongs_to :user
  belongs_to :team
  # infractions reported by this player
  has_many :infractions, :dependent => :destroy
  # a player can be a witness for multiple infractions
  has_many :witnesses, :dependent => :destroy
  has_many :suggestions, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  
  validates :name, :presence => true
  validates :last_names, :presence => true
  #validates :user, :presence => true
  validates :team, :presence => true
  
  AVATAR_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif', 'image/pjepg', 'image/x-png']
  
  def full_name
    "#{self.name} #{self.last_names}"
  end

	#paperclip_image:
  has_attached_file :avatar, :styles => { :thumb => "48x48", :medium => "128x128" }, 
    :default_url => 'player_:style.png'

  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => AVATAR_CONTENT_TYPES
end
