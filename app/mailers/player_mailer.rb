class PlayerMailer < ActionMailer::Base
  default :from => "Avantica Green <green@avantica.net>"

  helper :infractions

  def infraction_notification(infraction, action)
    @infraction = infraction
    @action = action

    # send notification to all players who belong to the offending team
    @infraction.offender.players.each do |player|
      if notify?(player, :infraction)
        @recipient = player
        mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
          :subject => "Infraction has been #{@action}").deliver
      end
    end

  end
  
  def witness_notification(witness, action)
    @witness = witness
    @recipient = @witness.player
    @infraction = @witness.infraction
    @action = action

    if notify?(@recipient, :witness)
      mail(:to => "#{@recipient.full_name} <#{@recipient.user.email}>", 
        :subject => "You have been #{@action} as a witness of an infraction").deliver
    end
  end

  private

  def notify?(player, notification_type, action = @action)
    full_type = "#{notification_type}_#{action}".to_sym

    case full_type
    when :infraction_created
      player.notify_infraction_add?
    when :infraction_updated
      player.notify_infraction_update?
    when :witness_added
      player.notify_witness_add?
    when :witness_removed
      player.notify_witness_remove?
    else
      false
    end
  end

end
