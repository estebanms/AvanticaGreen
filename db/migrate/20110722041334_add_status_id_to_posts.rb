class AddStatusIdToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :status_id, :integer
    # mark the existing suggestions as "Accepted"
    Post.update_all("status_id = #{Status.find_by_name('Accepted').id}", 'status_id IS NULL')
    Status.create(:name => 'Closed', :description => 'Closed')
  end

  def self.down
    remove_column :posts, :status_id
    Status.find_by_name('Closed').delete
  end
end
