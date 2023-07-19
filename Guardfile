# A sample Guardfile
# More info at https://github.com/guard/guard#readme

## Uncomment and set this to only include directories you want to watch
# directories %w(app lib config test spec features) \
#  .select{|d| Dir.exist?(d) ? d : UI.warning("Directory #{d} does not exist")}

## Note: if you are using the `directories` clause above and you are not
## watching the project directory ('.'), then you will want to move
## the Guardfile to a watched dir and symlink it back, e.g.
#
#  $ mkdir config
#  $ mv Guardfile config/
#  $ ln -s config/Guardfile .
#
# and, you'll have to watch "config/Guardfile" instead of "Guardfile"

# Guard-Rails supports a lot options with default values:
# daemon: false                        # runs the server as a daemon.
# debugger: false                      # enable ruby-debug gem.
# environment: 'development'           # changes server environment.
# force_run: false                     # kills any process that's holding the listen port before attempting to (re)start Rails.
# pid_file: 'tmp/pids/[RAILS_ENV].pid' # specify your pid_file.
# host: 'localhost'                    # server hostname.
# port: 3000                           # server port number.
# root: '/spec/dummy'                  # Rails' root path.
# server: thin                         # webserver engine.
# start_on_start: true                 # will start the server when starting Guard.
# timeout: 30                          # waits untill restarting the Rails server, in seconds.
# zeus_plan: server                    # custom plan in zeus, only works with `zeus: true`.
# zeus: false                          # enables zeus gem.
# CLI: 'rails server'                  # customizes runner command. Omits all options except `pid_file`!

guard 'rails', CLI: 'rails server -b 0.0.0.0 -p 3000' do
  watch('Gemfile.lock')
  watch(/^(config|lib)\/.*/)
end

cmd = ENV['GUARD_CMD'] || (ENV['SPRING'] ? 'spring rspec' : 'bundle exec rspec')

directories %w[app lib spec]

rspec_context_for = proc do |context_path|
  require 'guard/rspec/dsl'
  OpenStruct.new(to_s: 'spec').tap do |rspec|
    rspec.spec_dir = "#{context_path}spec"
    rspec.spec = ->(m) { Guard::RSpec::Dsl.detect_spec_file_for(rspec, m) }
    rspec.spec_helper = "#{rspec.spec_dir}/spec_helper.rb"
    rspec.spec_files = /^#{rspec.spec_dir}\/.+_spec\.rb$/
    rspec.spec_support = /^#{rspec.spec_dir}\/support\/(.+)\.rb$/
  end
end

rails_context_for = proc do |context_path, exts|
  OpenStruct.new.tap do |rails|
    rails.app_files = /^#{context_path}app\/(.+)\.rb$/

    rails.views = /^#{context_path}app\/(views\/.+\/[^\/]*\.(?:#{exts}))$/
    rails.view_dirs = /^#{context_path}app\/views\/(.+)\/[^\/]*\.(?:#{exts})$/
    rails.layouts = /^#{context_path}app\/layouts\/(.+)\/[^\/]*\.(?:#{exts})$/

    rails.controllers = /^#{context_path}app\/controllers\/(.+)_controller\.rb$/
    rails.routes = "#{context_path}config/routes.rb"
    rails.app_controller = "#{context_path}app/controllers/application_controller.rb"
    rails.spec_helper = "#{context_path}spec/rails_helper.rb"
  end
end

guard_setup = proc do |context_path|
  # RSpec files
  rspec = rspec_context_for.call(context_path)
  watch(rspec.spec_helper) { rspec.spec_dir }
  watch(rspec.spec_support) { rspec.spec_dir }
  watch(rspec.spec_files)

  # Ruby files
  watch(/^#{context_path}(lib\/.+)\.rb$/) { |m| rspec.spec.call(m[1]) }

  # Rails files
  rails = rails_context_for.call(context_path, %w[erb haml slim])
  watch(rails.app_files) { |m| rspec.spec.call(m[1]) }
  watch(rails.views) { |m| rspec.spec.call(m[1]) }

  # Rails config changes
  watch(rails.spec_helper) { rspec.spec_dir }

  # Capybara features specs
  watch(rails.view_dirs) { |m| rspec.spec.call("features/#{m[1]}") }
  watch(rails.layouts) { |m| rspec.spec.call("features/#{m[1]}") }
end

guard :rspec, cmd:, spec_paths: ['spec/'] do |context_path|
  guard_setup.call(context_path)
end
