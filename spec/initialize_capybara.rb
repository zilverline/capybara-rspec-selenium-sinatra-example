# frozen_string_literal: true

require 'webdrivers/chromedriver'
require 'random-port'

RandomPort::Pool.new.acquire do |port|
  Capybara.server_port = port.to_s
end

options = Selenium::WebDriver::Chrome::Options.new.tap do |opts|
  opts.add_argument('--headless') unless ENV['NOT_HEADLESS']
  opts.add_argument('--window-size=1280,1024')
end

Capybara.register_driver :local_headless_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, capabilities: [options])
end

Capybara.default_driver = :local_headless_chrome

Capybara.app = Rack::Builder.parse_file(File.expand_path('../config.ru', __dir__)).first
