module InfractionsHelper
  def comments_link(infraction = @infraction)
    link_to "Comments (#{infraction.comments.size})", infraction_comments_path(infraction)
  end

  def witnesses_link(infraction = @infraction)
    link_to "Witnesses (#{infraction.witnesses.size})", infraction_witnesses_path(infraction)
  end
end
