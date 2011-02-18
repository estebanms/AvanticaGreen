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
    { :name => 'Monitor on', :description => 'Monitor on' },
    { :name => 'Lights on', :description => 'Lights on' },
    { :name => 'Water tap open', :description => 'Water tap open' },
    { :name => 'Other', :description => 'Other' },
  ]
  @@statuses = [
    { :name => 'Pending revision', :description => 'Pending revision' },
    { :name => 'Rejected', :description => 'Rejected' },
    { :name => 'Accepted', :description => 'Accepted' },
  ]
  
  def self.up
    @@comment_types.each { |type| CommentType.new(:name => type[:name], :description => type[:description]).save }
    @@suggestion_types.each { |type| SuggestionType.new(:name => type[:name], :description => type[:description]).save }
    @@infraction_types.each { |type| InfractionType.new(:name => type[:name], :description => type[:description]).save }
    @@statuses.each { |type| Status.new(:name => type[:name], :description => type[:description]).save }
  end

  def self.down
    @@comment_types.each { |type| CommentType.delete_all(:name => type[:name]) }
    @@suggestion_types.each { |type| SuggestionType.delete_all(:name => type[:name]) }
    @@infraction_types.each { |type| InfractionType.delete_all(:name => type[:name]) }
    @@statuses.each { |type| Status.delete_all(:name => type[:name]) }
  end
end
