class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_game
    Game.active.first
  end

  def current_player
    user_signed_in? ? current_user.player : nil
  end
end
