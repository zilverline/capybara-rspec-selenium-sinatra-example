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

Capybara.register_driver :remote_headless_chrome do |app|
  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    url: "http://#{ENV['SELENIUM_HOST']}:4444/wd/hub",
    capabilities: [options],
  )
end

Capybara.default_driver = ENV['SELENIUM_HOST'] ? :remote_headless_chrome : :local_headless_chrome

Capybara.app_host = "http://#{ENV['APP_HOST']}:#{Capybara.server_port}" if ENV['APP_HOST']

Capybara.app = Rack::Builder.parse_file(File.expand_path('../config.ru', __dir__)).first
