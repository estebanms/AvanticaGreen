class Post < ActiveRecord::Base
  belongs_to :player
  
  validates :player, :presence => true
  validates :description, :presence => true
  
  def player_name
    self.anonymous ? 'Anonymous' : self.player.full_name
  end
end
