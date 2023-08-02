# frozen_string_literal: true

# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

# Prevent database truncation if the environment is production

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

require 'shoulda/matchers'
require 'gon'
require 'database_cleaner/active_record'
require "factory_bot_rails"
require "faker"
require 'timecop'

# custom helper packages
Dir[File.join(__dir__, 'support/**/*.rb')].sort.each { |file| require file }

begin
	ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError
	exit 1
end

DatabaseCleaner.strategy = :truncation

RSpec.configure do |config|
	config.include ActiveSupport::Testing::TimeHelpers
	config.include Devise::Test::ControllerHelpers, type: :component
	config.include Devise::Test::ControllerHelpers, type: :controller
	config.include ViewComponent::TestHelpers, type: :component
	config.include Capybara::RSpecMatchers, type: :component
	config.include FactoryBot::Syntax::Methods
	config.include Rails.application.routes.url_helpers, type: :component
	config.include ApplicationHelper

	config.fixture_path = "#{::Rails.root}/spec/fixtures"
	config.use_transactional_fixtures = true
	config.filter_run :focus
	config.run_all_when_everything_filtered = true
	config.filter_run_excluding skip: true
	config.infer_spec_type_from_file_location!
	config.filter_rails_from_backtrace!

	config.before(:each, type: :feature) { Rails.application.load_seed }
	config.before(:each, type: :component) do
		@request = controller.request
	end

	config.before(:each) do
		DatabaseCleaner.clean
		Gon::Request.instance_variable_set(:@env, {})
	end

	Shoulda::Matchers.configure do |s_config|
		s_config.integrate do |with|
			with.test_framework :rspec
			with.library :rails
		end
  end
end
