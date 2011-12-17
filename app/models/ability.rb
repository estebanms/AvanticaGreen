class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest
    player = user.player
    
    if player && player.is_admin # superadmin
      can :manage, :all
    else
      if player # logged in
        # Edit my team's info
        can :update, Team, :id => player.team.id
        # Edit my own info
        can :update, Player, :id => player.id
        # Create infractions
        can :create, Infraction
        # Edit my own infractions
        can :update, Infraction, :player_id => player.id
        # Delete my own infractions only if they are 'pending'
        can :destroy, Infraction, :player_id => player.id, 
          :status_id => Status.pending.id
        # read, create and destroy witnesses of my own infractions
        can [:read, :create, :destroy], Witness, :infraction => { :player_id => player.id }
        # Manage my own comments
        can :manage, Comment, :player_id => player.id
        # Approve/reject being witness of an infraction
        can :update, Witness, :player_id => player.id
        can [:read, :create], Suggestion
        can [:update, :destroy], Suggestion, :player_id => player.id
      else
        # don't allow logged in users to create a new player
        can :create, Player
      end
      can :read, [Team, Player, Infraction, Comment, Witness]
    end
  end
end
