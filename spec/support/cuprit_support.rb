# First, load Cuprite Capybara integration
require 'capybara/cuprite'
require 'capybara/session'

# Then, we need to register our driver to be able to use it later
# with #driven_by method.
Capybara.register_driver(:cuprite) do |app|
  Capybara::Cuprite::Driver.new(
    app,
    **{
      window_size: [1400, 1000],
      # See additional options for Dockerized environment in the respective section of this article
      browser_options: {},
      # Increase Chrome startup wait time (required for stable CI builds)
      process_timeout: 10,
      timeout: 60,
      # Enable debugging capabilities
      inspector: true,
      # Allow running Chrome in a headful mode by setting HEADLESS env
      # var to a falsey value
      headless: false
    }
  )
end

# Configure Capybara to use :cuprite driver by default
Capybara.default_driver = Capybara.javascript_driver = :cuprite


module CupriteHelpers

  # Drop #pause anywhere in a test to stop the execution.
  # Useful when you want to checkout the contents of a web page in the middle of a test
  # running in a headfull mode.
  def pause
    page.driver.pause
  end

  # Drop #debug anywhere in a test to open a Chrome inspector and pause the execution
  def debug(*args)
    page.driver.debug(*args)
  end

  def click_and_drag(from, to)
    x1, y1 = from.native.node.find_position
    x2, y2 = to.native.node.find_position

    mouse = page.driver.browser.mouse
    mouse.move(x: x1, y: y1)
    mouse.down
    mouse.move(x: x2, y: y2)
    mouse.up
  end

end

RSpec.configure do |config|
  config.include CupriteHelpers, type: :feature
  config.include CupriteHelpers, type: :component
end
