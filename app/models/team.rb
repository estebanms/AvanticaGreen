class Team < ActiveRecord::Base
  has_many :players, :dependent => :restrict
  # infractions reported by this team
  has_many :infractions, :dependent => :restrict
  # infractions where this team is the offender
  has_many :infractions_as_offender, :foreign_key => 'offender_id', 
    :class_name => 'Infraction', :dependent => :restrict
  
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
end
