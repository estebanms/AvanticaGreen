module InfractionsHelper
  def infraction_details(infraction)
    "the infraction of type &quot;#{infraction.infraction_type}&quot;, 
    reported by the team #{infraction.reporter} on #{format_date(infraction.created_at)}, 
    committed by the team #{infraction.offender} and with a current status of &quot;#{infraction.status}&quot;"
  end
end
