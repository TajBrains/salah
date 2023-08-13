# frozen_string_literal: true

User.find_or_create_by!(email: ENV['ADMIN_EMAIL']) do |user|
  user.password = ENV['ADMIN_PASSWORD']
  user.password_confirmation = ENV['ADMIN_PASSWORD']
  user.admin!
end

Setting.find_or_create_by!(name: 'Main') do |setting|
  setting.settings = { background: nil, show_footer: false }
end
