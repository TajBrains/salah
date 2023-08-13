# frozen_string_literal: true

module ApplicationHelper
  def bg_image
    gradient_opacity = @bg_image&.opacity || 0.8
    image_url = @bg_image&.image&.url || image_path('bg-min.jpg')

    styles = <<~CSS
      background-image: linear-gradient(rgba(0, 0, 0, #{gradient_opacity}), rgba(0, 0, 0, #{gradient_opacity})), url(#{image_url});
      background-repeat: no-repeat;
      background-position: center;
      background-size: cover;
    CSS

    styles.html_safe
  end
end
