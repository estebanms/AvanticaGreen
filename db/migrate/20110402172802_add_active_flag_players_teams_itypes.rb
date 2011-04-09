class AddActiveFlagPlayersTeamsItypes < ActiveRecord::Migration
  def self.up
     add_column :players, :active, :boolean, :null => false, :default => true
     add_column :teams, :active, :boolean, :null => false, :default => true
     add_column :infraction_types, :active, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :players, :active
    remove_column :teams, :active
    remove_column :infraction_types, :active
  end
end
