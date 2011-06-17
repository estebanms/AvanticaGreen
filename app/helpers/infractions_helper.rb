module InfractionsHelper
  def witnesses_link(infraction = @infraction)
    link_to "Witnesses (#{infraction.witnesses.size})", infraction_witnesses_path(infraction)
  end
end
