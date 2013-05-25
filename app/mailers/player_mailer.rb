class PlayerMailer < ActionMailer::Base
  default :from => "Avantica Green <green@avantica.net>"

  helper :infractions

  def infraction_notification(infraction, action)
    @infraction = infraction
    @action = action

    # send notification to all players who belong to the offending team
    players = @infraction.offender.players
   
    players.each do |player|
      @recipient = player
      mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
        :subject => "Infraction has been #{@action}").deliver
    end

    # and send it to the player who created the infraction as well
    mail(:to => "#{@infraction.player.full_name} <#{@infraction.player.user.email}>", 
        :subject => "Infraction has been #{@action}").deliver

  end
  
  def witness_notification(witness, action)
    @witness = witness
    @recipient = @witness.player
    @infraction = @witness.infraction
    @action = action
    mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
      :subject => "You have been #{@action} as a witness of an infraction").deliver
  end
  
end
