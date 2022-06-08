# frozen_string_literal: true

require 'sinatra'

class HomePageController < Sinatra::Base
  get '/' do
    <<~HTML
<html>
  <body>
      Welcome!
  </body>
</html>
    HTML
  end
end

app = Rack::URLMap.new({
  '/' => HomePageController,
  # more urls here
})

run app
