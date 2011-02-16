class Infraction < ActiveRecord::Base
  belongs_to :game
  belongs_to :player
  belongs_to :team
  belongs_to :offender, :class_name => 'Team'
  belongs_to :infraction_type
  belongs_to :status
  has_many :witnesses, :dependent => :destroy
  
  validates :game, :presence => true
  validates :team, :presence => true
  validates :offender, :presence => true
  validates :infraction_type, :presence => true
  #validates :witnesses, :length => { :minimum => 1 }, :if => Proc.new { |infraction| infraction.photo.nil? }
  
  #paperclip image:
  has_attached_file :photo,
    :styles => {
       :thumb => "100x100#",
       :small  => "400x400>" 
    }
end
