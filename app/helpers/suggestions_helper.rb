module SuggestionsHelper
  def type_avatar(suggestion)
    file = suggestion.suggestion_type.to_s.downcase.gsub(/\s/, '_')
    image_tag("#{file}.png", alt: suggestion.suggestion_type.to_s, title: suggestion.suggestion_type.to_s)
  end
end
