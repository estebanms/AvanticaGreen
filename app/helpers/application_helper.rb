module ApplicationHelper
   
  def current_player
    user_signed_in? ? current_user.player : nil
  end
  
  def is_admin?
    current_player.nil? ? false : current_user.player.is_admin
  end
  
end
