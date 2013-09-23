class Game < ActiveRecord::Base
  attr_accessible :name, :active
  has_many :infractions, :dependent => :restrict_with_exception
  
  validates :start_date, :presence => true
	  
  scope :active, -> { where(:active => true).order('updated_at DESC') }
  
  before_save do
    # we only allow one active game at a time
    if self.active && Game.active.any?
      Game.active.each do |current_game|
        current_game.active = false
        current_game.save
      end
    end
  end
end
