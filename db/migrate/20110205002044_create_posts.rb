class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer :player_id
      t.text :description
      t.integer :post_type_id
      t.integer :infraction_id
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
