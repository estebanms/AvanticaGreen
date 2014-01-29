class Team < ActiveRecord::Base
  # TODO: It's not recomendable to have all fields accesible. This might need refactoring in order to make it more secure.
  attr_accessible :code, :team_logo, :name, :description, :active

  has_many :players, :dependent => :restrict_with_exception
  # infractions reported by this team
  has_many :infractions, :dependent => :restrict_with_exception
  # infractions where this team is the offender
  has_many :infractions_as_offender, :foreign_key => 'offender_id', 
    :class_name => 'Infraction', :dependent => :restrict_with_exception

  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

  scope :active, -> { where(:active => true) }
  scope :inactive, -> { where(:active => false) }

  LOGO_CONTENT_TYPES = ['image/jpeg', 'image/png', 'image/gif']

  #paperclip_image:
  has_attached_file :team_logo, 
    :styles => { :thumb => "48x48", :medium => "128x128" }, 
    :default_url => 'team_:style.png'
  validates_attachment_size :team_logo, :less_than => 5.megabytes
  validates_attachment_content_type :team_logo, :content_type => LOGO_CONTENT_TYPES

  class << self
    def sorted_by_score
      active.sort {|a, b| b.score <=> a.score }
    end

    def sorted_by_score_desc
      active.sort {|a, b| a.score <=> b.score }
    end
  
    def top_reporters
      active.sort {|a, b| b.infractions.accepted.size <=> a.infractions.accepted.size }
    end
  end

  def score
    @score ||= self.infractions_as_offender.active.accepted.reduce(0) { |sum, infraction| sum + infraction.infraction_type.points } 
    @score * -1
  end

  def to_s
    self.name
  end
end
