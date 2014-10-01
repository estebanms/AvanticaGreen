class AddNotificationColumnsToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :notify_witness_add, :boolean, default: true
    add_column :players, :notify_witness_remove, :boolean, default: true
    add_column :players, :notify_infraction_add, :boolean, default: true
    add_column :players, :notify_infraction_update, :boolean, default: true
  end
end
