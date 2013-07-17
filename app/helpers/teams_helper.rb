module TeamsHelper
  def teams_select(object, field_name = :team_id, options = {})
    admin = options.delete(:admin)
    teams = admin ? Team.all : Team.where(:active => true)
    collection_select(object, field_name, teams, :id, :name, options)
  end

  def winning_or_losing(all_teams, team)
    unless team.score == 0
      unless all_teams.first.score == all_teams.second.score
        (all_teams.first.score == team.score) ? image_tag("trophy.png") : "                 "
      end   
    
      (all_teams.last.score == team.score) ? image_tag("pig.png") : "                     "
    end
  end

end
