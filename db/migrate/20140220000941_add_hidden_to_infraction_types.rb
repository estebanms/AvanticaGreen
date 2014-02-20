class AddHiddenToInfractionTypes < ActiveRecord::Migration
  def change
    add_column :infraction_types, :hidden, :boolean, :default => false
  end
end
