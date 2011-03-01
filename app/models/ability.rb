class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest
    player = user.player
    
    if player && player.is_admin # superadmin
      can :manage, :all
    elsif player # logged in
      # TODO: add validations for non-admin, logged in users
    else # not logged in
      # TODO: add validations for not logged in users
    end
  end
end
