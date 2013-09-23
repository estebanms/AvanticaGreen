module TeamsHelper
  TROPHY_IMAGE = 'trophy.png'
  PIG_IMAGE    = 'pig.png' 

  def teams_select(object, field_name = :team_id, options = {})
    admin = options.delete(:admin)
    teams = admin ? Team.all : Team.where(:active => true)
    collection_select(object, field_name, teams, :id, :name, options)
  end

  def winning_or_losing(all_teams, team)
    max_score = all_teams.first.score
    min_score = all_teams.last.score 
    case all_teams.size
    when 1
      image_tag(TROPHY_IMAGE)
    else
      if (max_score == team.score)
        image_tag(TROPHY_IMAGE) if max_score != all_teams.second.score
      elsif min_score == team.score
        image_tag(PIG_IMAGE) 
      end
    end    
  end

end
