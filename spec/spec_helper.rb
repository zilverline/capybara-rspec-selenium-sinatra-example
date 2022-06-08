# frozen_string_literal: true

require 'capybara/rspec'
require 'capybara/dsl'

RSpec.configure do |config|
  config.include Capybara::DSL, :features

  config.define_derived_metadata(file_path: %r{/spec/features/}) do |metadata|
    metadata[:features] = true
  end

  config.before :all, :features do
    require_relative 'initialize_capybara'
  end

  config.after :each, :features do |example|
    if example.exception
      filename = File.basename(example.metadata[:file_path])
      line_number = example.metadata[:line_number]
      timestamp = Time.now.strftime('%Y-%m-%d-%H-%M-%S')

      screenshot_path = "/tmp/capybara/#{filename}-#{line_number}-#{timestamp}.png"

      Capybara.page.save_screenshot(screenshot_path)
      puts "\n"
      puts "Screenshot: #{screenshot_path}"
    end
  end

  config.after :each, :features do
    Capybara.current_session.driver.quit
  end
end
