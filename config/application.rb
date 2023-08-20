# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module SalahApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    config.time_zone = 'Berlin'

    initializer 'app_assets', after: 'importmap.assets' do
      Rails.application.config.assets.paths << Rails.root.join('app')
    end

    # I18n
    config.i18n.default_locale = :tr

    config.importmap.cache_sweepers << Rails.root.join('app/components')

    config.active_storage.resolve_model_to_route = :rails_storage_proxy
  end
end
