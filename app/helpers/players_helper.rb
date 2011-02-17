module PlayersHelper
  def players_select(object, field_name = :player_id, options = {})
    collection_select(object, field_name, Player.all, :id, :full_name, options)
  end
end
