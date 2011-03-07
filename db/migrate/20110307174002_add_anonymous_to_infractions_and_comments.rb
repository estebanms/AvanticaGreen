class AddAnonymousToInfractionsAndComments < ActiveRecord::Migration
  def self.up
    add_column :infractions, :anonymous, :boolean, :null => false, :default => false
    add_column :posts, :anonymous, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :infractions, :anonymous
    remove_column :posts, :anonymous
  end
end
