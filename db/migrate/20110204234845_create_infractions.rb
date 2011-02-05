class CreateInfractions < ActiveRecord::Migration
  def self.up
    create_table :infractions do |t|
      t.integer :game_id
      t.integer :player_id
      t.integer :team_id
      t.integer :offender_id
      t.integer :infraction_type_id
      t.integer :status_id
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :infractions
  end
end
