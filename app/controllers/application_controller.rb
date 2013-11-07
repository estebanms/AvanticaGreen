class ApplicationController < ActionController::Base
  rescue_from DeviseLdapAuthenticatable::LdapException do |exception|
    render :text => exception, :status => 500
  end
   
  before_filter :create_player

  protect_from_forgery
  
  helper_method :current_player
  
  rescue_from CanCan::AccessDenied, :with => :not_authorized
  
  def current_game
    Game.active.first
  end

  def current_player
    user_signed_in? ? current_user.player : nil
  end

  def create_player
    if user_signed_in? && current_user.player.nil?
      player = Player.new(:name => Devise::LDAP::Adapter.get_ldap_param(current_user.email, 'givenName').first.to_s)
      player.last_names = Devise::LDAP::Adapter.get_ldap_param(current_user.email, 'sn').first.to_s
      player.user_id = current_user.id
      player.team_id = Team.where(name: 'Available Players').first.id
      player.save
    end
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
