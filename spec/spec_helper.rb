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

end
