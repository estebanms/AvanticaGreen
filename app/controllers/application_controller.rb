class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_player
  
  rescue_from CanCan::AccessDenied, :with => :not_authorized
  
  def current_game
    Game.active.first
  end

  def current_player
    user_signed_in? ? current_user.player : nil
  end
  
  def not_authorized
    error_message = 'You are not authorized to see this page.'
    if user_signed_in?
      flash[:error] = error_message
      redirect_to root_path
    else
      error_message += ' Please sign in first.'
      flash[:error] = error_message
      session[:return_to] = request.fullpath
      redirect_to new_user_session_path
    end
  end
  
  # overwrite redirection after successful sign in
  def after_sign_in_path_for(resource_or_scope)
    session[:return_to] || super
  end

end
