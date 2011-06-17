module CommentsHelper
  # routes for comments
  def comments_path(options = {})
    polymorphic_path([@commentable, Comment], options)
  end

  def comments_url(options = {})
    comments_path(options)
  end

  def comment_path(comment, options = {})
    polymorphic_path([@commentable, comment], options)
  end

  def comment_url(comment, options = {})
    comment_path(comment, options)
  end

  def edit_comment_path(comment, options = {})
    edit_polymorphic_path([@commentable, comment], options)
  end

  def new_comment_path(options = {})
    new_polymorphic_path([@commentable, Comment], options)
  end

  def comments_link(commentable)
    link_to "Comments (#{commentable.comments.size})", polymorphic_path([commentable, Comment])
  end
end
