class AddIsAdminColumnToPlayers < ActiveRecord::Migration
  def self.up
    add_column :players, :is_admin, :boolean,:null => false, :default => false
  end

  def self.down
    remove_column :players, :is_admin
  end
end
