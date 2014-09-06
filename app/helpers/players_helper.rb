module PlayersHelper
  def players_select(object, field_name = :player_id, options = {})
    exclude_team = options.delete(:exclude_team)
    players = Player.playing
    players = players.where.not(team_id: exclude_team.id) if exclude_team
    collection_select(object, field_name, players, :id, :full_name, options)
  end
end
