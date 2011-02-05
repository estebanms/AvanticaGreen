class CreateInfractionTypes < ActiveRecord::Migration
  def self.up
    create_table :infraction_types do |t|
      t.string :name
      t.integer :points
      t.text :description

      t.timestamps
    end
  end

  def self.down
    drop_table :infraction_types
  end
end
