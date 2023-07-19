module ApplicationHelper
  def bg_image_v2
    "background-image: linear-gradient(rgba(0, 35, 0, .7), rgba(0, 0, 0, .8)),url(#{image_path("green-bg.jpg")}); backdrop-filter: blur(2px);"
  end

  def bg_image_v1
    "background-image: linear-gradient(rgba(0, 0, 0, .8), rgba(0, 0, 0, .8)),url(#{image_path("bg-min.jpg")});"
  end

  def bg_image_v3
    "
      background-image: linear-gradient(rgba(0, 0, 0, .8), rgba(0, 0, 0, .8)),url(#{image_path("black-bg.png")});
      background-repeat: no-repeat;
      background-position: center;
      background-size: cover;
    "
  end
end
