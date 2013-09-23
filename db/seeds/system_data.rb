class SystemData

  ACCESSIBLE_FIELDS = %w(name description active) 

  DATA = {
    statuses: [
      { name: 'Pending revision', description: 'Pending revision' },
      { name: 'Rejected',         description: 'Rejected' },
      { name: 'Accepted',         description: 'Accepted' },
    ],
    comment_types: [
      { name: 'General Comment', description: 'General comment' },
      { name: 'Justification',   description: 'Justification' },
      { name: 'Contribution',    description: 'Contribution' },
    ],
    suggestion_types: [
      { name: 'General Suggestion', description: 'General suggestion' },
      { name: 'Enhancement',        description: 'Enhancement' },
      { name: 'Bug',                description: 'Bug' },
      { name: 'Question',           description: 'Question' },
    ],
    games: [
      { name: 'old game',     start_date: '2010-11-01', end_date: '2010-12-31', active: false },
      { name: 'current game', start_date: '2011-01-01', end_date: '2011-06-31', active: true },
    ],
    infraction_types: [
      { name: 'Unsorted trash', description: 'Unsorted trash', points: 20, active: true },
      { name: 'Monitor on',     description: 'Monitor on',     points: 15, active: true },
      { name: 'Lights on',      description: 'Lights on',      points: 10, active: true },
      { name: 'Messy desk',     description: 'Messy desk',     points: 5,  active: true },
      { name: 'Other',          description: 'Other',          points: 1,  active: true },
      { name: 'Inactive',       description: 'Intactive',      points: 1,  active: false },
    ],
    teams: [
      { name: 'Administrators', description: 'System administrators', code: 'aaa', active: false },
      { name: 'Available Players', description: 'New players who have joined the game and have not yet been added to a team', code: 'xyzu', active: false },
      { name: 'Trash', description: 'Deleted players', code: 'abc', active: false },
    ],
    players: [ #Order is important
     #default administrator
     { name: 'Admin', last_names: 'Admin', user_id: 1, team_id: 1, is_admin: true, active: false },
    ],
  }



  def load_data
    DATA.each_pair do |key, values|
      # Model
      klass = key.to_s.classify.constantize

      puts "Clearing data for #{klass.name}...."
      klass.delete_all

      puts "Loading data for: #{klass.name}:..."
      values.each do |record_data|
        record = klass.new
        # Setting the rest of the no accessible fields for the instance
        record_data.each_pair do |field,value|
          record.send("#{ field }=", value)
        end
        # Will make noise if it fails
        record.save!
      end

    end
  end


  def clear_models
    DATA.each_pair do |key, values|
      klass = key.to_s.classify.constantize
      klass.delete_all
    end
  end


end
