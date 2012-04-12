module ApplicationHelper
  FLASH_TYPES = [
    :notice, 
    :message, 
    :warning, 
    :error
  ]
  
  def display_flash_messages(type = :all)
    flash_messages = Array.new
    flash_types = (type == :all) ? FLASH_TYPES : [type]
    flash_types.each do |flash_type|
      flash_messages << "<p id=\"#{flash_type}\">#{flash[flash_type]}</p>" if flash[flash_type]
    end
    return flash_messages.join('\n')
  end
  
  def post_player_name(post)
    post.anonymous? ? 'Anonymous' : link_to(post.player.full_name, post.player)
  end
  
  def post_player_image(post, image_style = :thumb)
    image_url = post.anonymous? ? "player_#{image_style}.png" : post.player.avatar.url(image_style)
    image_tag(image_url,:style => "height:36px;vertical-align:middle")
  end
end
