require 'paperclip'

class Player < ActiveRecord::Base
  belongs_to :user
  belongs_to :team
  # infractions reported by this player
  has_many :infractions, :dependent => :nullify
  # a player can be a witness for multiple infractions
  has_many :witnesses, :dependent => :destroy
  has_many :suggestions, :dependent => :nullify
  has_many :comments, :dependent => :nullify
  
  validates :name, :presence => true
  validates :last_names, :presence => true
  #validates :user, :presence => true
  validates :team, :presence => true
  
  def full_name
    "#{self.name} #{self.last_names}"
  end

	#paperclip_image:
  has_attached_file :avatar, :styles => { :thumb => "39x39", :medium => "155x155" }, 
    :default_url => '/images/player_:style.gif'

  validates_attachment_size :avatar, :less_than => 5.megabytes
  validates_attachment_content_type :avatar, :content_type => ['image/jpeg', 'image/png']
end
