module TeamsHelper
  def teams_select(object, field_name = :team_id, options = {})
    admin = options.delete(:admin)
    teams = admin ? Team.all : Team.where(:active => true)
    collection_select(object, field_name, teams, :id, :name, options)
  end
end
