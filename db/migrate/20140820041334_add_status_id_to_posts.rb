class AddStatusIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :status_id, :integer
    # mark the existing suggestions as "Accepted"
    Post.where('status_id IS NULL').update_all("status_id = #{Status.accepted.id}")
    Status.create(:name => 'Closed', :description => 'Closed')
  end

  def self.down
    remove_column :posts, :status_id
    Status.closed.delete
  end
end
