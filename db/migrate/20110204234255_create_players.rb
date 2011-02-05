class CreatePlayers < ActiveRecord::Migration
  def self.up
    create_table :players do |t|
      t.string :name
      t.string :last_names
      t.integer :user_id
      t.integer :team_id

      t.timestamps
    end
  end

  def self.down
    drop_table :players
  end
end
