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
    self.infractions_as_offender.accepted.map { |infraction| infraction.infraction_type.points }.sum
  end
  
  scope :sorted_by_score, all.sort {|a, b| b.score <=> a.score }

  #paperclip_image:
  has_attached_file :team_logo, 
    :styles => { :thumb => "48x48", :medium => "128x128" }, 
    :default_url => '/images/team_:style.png'
  validates_attachment_size :team_logo, :less_than => 5.megabytes
  validates_attachment_content_type :team_logo, :content_type => ['image/jpeg', 'image/png']
end
