class AddValuesForListableModels < ActiveRecord::Migration
  @@comment_types = [
    { :name => 'General Comment', :description => 'General comment' },
    { :name => 'Justification', :description => 'Justification' },
    { :name => 'Contribution', :description => 'Contribution' },
  ]
  @@suggestion_types = [
    { :name => 'General Suggestion', :description => 'General suggestion' },
    { :name => 'Enhancement', :description => 'Enhancement' },
    { :name => 'Bug', :description => 'Bug' },
    { :name => 'Question', :description => 'Question' },
  ]
  @@infraction_types = [
    { :name => 'Unsorted trash', :description => 'Unsorted trash', :points => 20, :active => true },
    { :name => 'Monitor on', :description => 'Monitor on', :points => 15, :active => true },
    { :name => 'Lights on', :description => 'Lights on', :points => 10, :active => true },
    { :name => 'Messy desk', :description => 'Messy desk', :points => 5, :active => true },
    { :name => 'Other', :description => 'Other', :points => 1, :active => true },
    { :name => 'Inactive', :description => 'Intactive', :points => 1, :active => false },
  ]
  @@statuses = [
    { :name => 'Pending revision', :description => 'Pending revision' },
    { :name => 'Rejected', :description => 'Rejected' },
    { :name => 'Accepted', :description => 'Accepted' },
  ]
  @@games = [
    { :name => 'old game', :start_date => '2010-11-01', :end_date => '2010-12-31', :active => false },
    { :name => 'current game', :start_date => '2011-01-01', :end_date => '2011-06-31', :active => true },
  ]
  @@teams = [
    { :name => 'Administrators', :description => 'System administrators', :code => 'aaa', :active => false},
    { :name => 'Available Players', :description => 'New players who have joined the game and have not yet been added to a team', :code => 'xyzu', :active => false},
    { :name => 'Trash', :description => 'Deleted players', :code => 'abc', :active => false},
  ]
  @@players = [
    #default administrator
    { :name => 'Admin', :last_names => 'Admin',:user_id => 1, :team_id => 1, :is_admin => true, :active => false},
  ]
  
  def self.up
    @@comment_types.each { |type| CommentType.new(:name => type[:name], :description => type[:description]).save }
    @@suggestion_types.each { |type| SuggestionType.new(:name => type[:name], :description => type[:description]).save }
    @@infraction_types.each { |type| InfractionType.new(:name => type[:name], :description => type[:description], :points => type[:points], :active => type[:active]).save }
    @@statuses.each { |type| Status.new(:name => type[:name], :description => type[:description]).save }
    @@games.each { |type| Game.new(:name => type[:name], :active => type[:active], :start_date => type[:start_date], :end_date => type[:end_date]).save }
    @@teams.each { |type| Team.new(:name => type[:name], :description => type[:description], :code => type[:code], :active => type[:active]).save              
    }
    @@players.each { |type| Player.new(:name => type[:name], :last_names => type[:last_names],:user_id => type[:user_id], :team_id => type[:team_id], :is_admin => type[:is_admin], :active => type[:active]).save }
  end

  def self.down
    @@comment_types.each { |type| CommentType.delete_all(:name => type[:name]) }
    @@suggestion_types.each { |type| SuggestionType.delete_all(:name => type[:name]) }
    @@infraction_types.each { |type| InfractionType.delete_all(:name => type[:name]) }
    @@statuses.each { |type| Status.delete_all(:name => type[:name]) }
    @@games.each { |type| Game.delete_all(:name => type[:name]) }
    @@teams.each { |type| Team.delete_all(:name => type[:name]) }
    @@players.each { |type| Team.delete_all(:name => type[:name]) }
  end
end
