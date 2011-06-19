class PlayerMailer < ActionMailer::Base
  default :from => "avanticagreen@avantica.net"
  
  def infraction_update(infraction, player)
    @infraction = infraction 
    @player = player
    mail(:to => "#{player.full_name} <#{player.user.email}>", :subject => "Infraction has been updated")
  end
  
  def witness_notification(witness, action)
    @witness = witness
    @infraction = witness.infraction
    @action = action
    subject = ((action == 'added') ? 'You have been added as a witness to an infraction' : 
      'You have been removed as a witness from an infraction')
    mail(:to => "#{witness.player.full_name} <#{witness.player.user.email}>", :subject => "#{subject}")
  end
  
end
