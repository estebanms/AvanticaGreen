class PlayerMailer < ActionMailer::Base
  default :from => "Avantica_Green@avantica.net"
  
  def self.infraction_update(infraction, action)
    @infraction = infraction
    @action = action
    # send notification to all players who belong to the offending team
    players = @infraction.offender.players
    # and send it to the player who created the infraction as well
    players << @infraction.player
    players.each do |player|
      @recipient = player
      mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
        :subject => "Infraction has been #{@action}")
    end
  end
  
  def self.witness_notification(witness, action)
    @witness = witness
    @recipient = @witness.player
    @infraction = @witness.infraction
    @action = action
    mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
      :subject => "You have been #{@action} as a witness of an infraction")
  end
  
end
