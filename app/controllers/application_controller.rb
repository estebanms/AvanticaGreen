class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_player, :is_admin?
  
  def current_game
    Game.active.first
  end

  def current_player
    user_signed_in? ? current_user.player : nil
  end
  
  def is_admin?
    current_player && current_player.is_admin
  end

end
