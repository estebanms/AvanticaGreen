module PlayersHelper
  def players_select(object, field_name = :player_id, options = {})
    collection_select(object, field_name, Player.where(:active => true), :id, :full_name, options)
  end
end
