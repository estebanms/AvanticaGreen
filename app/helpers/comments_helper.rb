module CommentsHelper
  # routes for comments
  def comments_path(options = {})
    infraction_comments_path(@infraction, options)
  end

  def comments_url(options = {})
    comments_path(options)
  end

  def comment_path(comment, options = {})
    infraction_comment_path(@infraction, comment, options)
  end

  def comment_url(comment, options = {})
    comment_path(comment, options)
  end

  def edit_comment_path(comment, options = {})
    edit_infraction_comment_path(@infraction, comment, options)
  end

  def new_comment_path(options = {})
    new_infraction_comment_path(@infraction, options)
  end
end
