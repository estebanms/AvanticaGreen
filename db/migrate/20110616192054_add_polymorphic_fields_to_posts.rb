class AddPolymorphicFieldsToPosts < ActiveRecord::Migration
  def self.up
    add_column :posts, :commentable_id, :integer
    add_column :posts, :commentable_type, :string
    Comment.reset_column_information
    Comment.all.each do |comment|
      comment.commentable_id = comment.infraction_id
      comment.commentable_type = Infraction.to_s
      comment.save
    end
    remove_column :posts, :infraction_id
  end

  def self.down
    add_column :posts, :infraction_id, :integer
    Comment.reset_column_information
    Comment.all.each do |comment|
      comment.infraction_id = comment.commentable_id
      comment.save
    end
    remove_column :posts, :commentable_id, :commentable_type
  end
end
