module InfractionsHelper
  include DatesHelper

  def infraction_related_team(infraction, type, options = {})
    options[:return_as_link] = true if options[:return_as_link].nil?
    options[:link_options] ||= {}
    options[:html_options] ||= {}
    options[:html_options].merge!({ :class => 'tooltipTrigger' })
    type = :team if type.to_sym.eql?(:reporter)

    related_team = infraction.send(type.to_s)
    related_team_text = related_team.to_s
    related_team_text = link_to(
      related_team_text, 
      team_path(related_team, options[:link_options]), 
      options[:html_options]
    ) if options[:return_as_link]

    # include the player info if we're displaying the reporter team and the infraction is not anonymous
    if type.to_sym.eql?(:team) and not infraction.anonymous?
      player_text = infraction.player.full_name
      player_text = link_to(
        player_text, 
        player_path(infraction.player, options[:link_options]), 
        options[:html_options]
      ) if options[:return_as_link]
      related_team_text += raw(" (#{player_text})")
    end

    related_team_text
  end

  def infraction_details(infraction)
    reporter_team = infraction_related_team(infraction, :reporter, { :link_options => options_for_mail_link })
    offender_team = infraction_related_team(infraction, :offender, { :link_options => options_for_mail_link })
    "the infraction of type \"#{infraction.infraction_type}\", 
    reported by the team #{reporter_team} on #{format_date(infraction.created_at)}, 
    committed by the team #{offender_team} and with a current status of \"#{infraction.status}\""
  end

  def options_for_mail_link
    { :only_path => false, :host => AvanticaGreen::Application::ROOT_PATH }
  end
end
