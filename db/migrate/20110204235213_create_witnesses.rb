class CreateWitnesses < ActiveRecord::Migration
  def self.up
    create_table :witnesses do |t|
      t.integer :player_id
      t.integer :infraction_id
      t.integer :status_id

      t.timestamps
    end
  end

  def self.down
    drop_table :witnesses
  end
end
