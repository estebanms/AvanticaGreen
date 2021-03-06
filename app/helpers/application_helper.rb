module ApplicationHelper
  FLASH_TYPES = [
    :notice, 
    :message, 
    :warning, 
    :error,
    :alert
  ]

  def display_flash_messages(type = :all)
    flash_messages = Array.new
    flash_types = (type == :all) ? FLASH_TYPES : [type]
    flash_types.each do |flash_type|
      flash_messages << "<p id=\"#{flash_type}\">#{flash[flash_type]}</p>" if flash[flash_type]
    end
    return flash_messages.join('\n')
  end

  def display_form_field?(field_name)
    @permitted_params.present? && @permitted_params.include?(field_name)
  end

  def post_player_name(post)
    post.anonymous? ? 'Anonymous' : link_to(post.player.full_name, post.player, { :class => 'tooltipTrigger' })
  end

  def post_player_image(post, image_style = :thumb)
    image_url = post.anonymous? ? "player_#{image_style}.png" : post.player.avatar.url(image_style)
    image_tag(image_url,:style => "height:36px;vertical-align:middle")
  end

  def nothing_to_show(type, addendum = '')
    "There are no #{type} to display#{addendum}."
  end

  def crop_text(text, length = 100)
    truncate(text, length: length)
  end

  # Common Image_Link
  def show_image(alt = 'Show me more')
    image_tag('show.png', alt: alt, title: alt)
  end

  def edit_image(default_alt = 'element')
    alt = "Edit this #{default_alt}"
    image_tag('edit.png', alt: alt, title: alt)
  end

  def destroy_image(default_alt = 'element')
    alt = "Delete this #{default_alt}"
    image_tag('trash.png', alt: alt, title: alt)
  end

  def show_link(obj, options = {})
    options[:alt] ||= 'Show me more'
    link_to show_image(options[:alt]), obj, { class: 'image_link' }.merge(options)
  end

  def edit_link(obj, options = {})
    options[:alt] ||= 'element'
    link_to edit_image(options[:alt]), obj, { class: 'image_link' }.merge(options)
  end

  def destroy_link(obj, options = {})
    options[:alt] ||= 'element'
    link_to destroy_image(options[:alt]), obj, { data: { confirm: 'Are you sure?' }, method: :delete, class: 'image_link' }.merge(options)
  end

end
