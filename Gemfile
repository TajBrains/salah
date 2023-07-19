source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.1"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.5"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]

  # handle env vars in development
  gem 'dotenv-rails'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
  gem 'guard-rails'
  gem 'guard-rspec'
  gem 'guard-sidekiq'
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem 'cuprite'
  gem 'simplecov', require: false
  gem 'simplecov-lcov', require: false

  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'populator'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'timecop'
  gem 'database_cleaner-active_record'
end

gem 'hotwire-rails', '~> 0.1.3'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

gem 'business_time', '~> 0.11.0'
gem 'groupdate', '~> 6.0'
gem 'haml-rails'
gem 'view_component', '~> 2.52'
gem 'time_difference', '~> 0.5.0'
gem 'draper', '~> 4.0'
gem 'gon'
gem 'aasm'
gem 'matrix', '~> 0.4.2'

# Sidekiq
gem 'sidekiq', '~> 6.5'
gem 'sidekiq-cron'

# Devise
gem 'devise', '~> 4.8'
gem 'devise_invitable'

# Use postgres as database for AR
gem 'pg'
gem 'pg_search'

gem 'interactor', '~> 3.1'

gem 'rails_accordion'

gem 'httparty'
gem 'hijri'

gem 'stimulus_reflex', '= 3.5.0.pre8'
