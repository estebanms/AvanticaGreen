module InfractionsHelper
  include DatesHelper

  def infraction_details(infraction)
    "the infraction of type \"#{infraction.infraction_type}\", 
    reported by the team #{infraction.reporter} on #{format_date(infraction.created_at)}, 
    committed by the team #{infraction.offender} and with a current status of \"#{infraction.status}\""
  end
end
