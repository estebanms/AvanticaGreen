class ScoreController < ApplicationController
  def index
    # debo cambiaar esto a active record cuando haya estudiado la version para rails 3
     @table = Infraction.find_by_sql("
      select t.name, sum(it.points) as score from infractions inf 
      join infraction_types it on it.id = inf.infraction_type_id
      join teams t on t.id = inf.offender_id
      join statuses s on s.id = inf.status_id
      where game_id = #{current_game.id.to_s} and s.name = 'Accepted'
      group by inf.offender_id
      order by score asc")
  end
end
