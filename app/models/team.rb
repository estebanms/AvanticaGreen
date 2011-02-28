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
    self.infractions_as_offender.map { |infraction| infraction.infraction_type.points }.sum
  end
  
  scope :sorted_by_score, all.sort {|a, b| b.score <=> a.score }
end
