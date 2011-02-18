module TeamsHelper
  def teams_select(object, field_name = :team_id, options = {})
    collection_select(object, field_name, Team.all, :id, :name, options)
  end
end