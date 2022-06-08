# frozen_string_literal: true

require 'spec_helper'

describe 'home page' do
  it 'welcomes the user' do
    visit '/'
    expect(page).to have_content 'Welcome!'
  end
end
