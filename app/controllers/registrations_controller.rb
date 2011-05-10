class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    new_player_path(:user_id => current_user)
  end
  
  def after_inactive_sign_up_path_for(resource)
    new_player_path(:user_id => current_user)
  end
end

