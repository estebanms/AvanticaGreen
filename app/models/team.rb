class Team < ActiveRecord::Base
  has_many :players, :dependent => :restrict
  # infractions reported by this team
  has_many :infractions, :dependent => :restrict
  # infractions where this team is the offender
  has_many :infractions_as_offender, :foreign_key => 'offender_id', 
    :class_name => 'Infraction', :dependent => :restrict
  
  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true
  
  def score
    self.infractions_as_offender.active.accepted.map { |infraction| infraction.infraction_type.points }.sum
  end
  
  scope :active, where(:active => true)
  scope :inactive, where(:active => false)

  LOGO_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif']

  #paperclip_image:
  has_attached_file :team_logo, 
    :styles => { :thumb => "48x48", :medium => "128x128" }, 
    :default_url => '/images/team_:style.png'
  validates_attachment_size :team_logo, :less_than => 5.megabytes
  validates_attachment_content_type :team_logo, :content_type => LOGO_CONTENT_TYPES

  def self.sorted_by_score
    self.active.sort {|a, b| b.score <=> a.score }
  end
  
  def to_s
    self.name
  end
end
