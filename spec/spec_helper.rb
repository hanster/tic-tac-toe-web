require 'simplecov'
SimpleCov.start do
  add_filter "spec/"
end

require 'rack/test'
require 'rack'
require 'tic_tac_toe_web/app'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  def app
    path = File.expand_path('../config.ru', File.dirname(__FILE__))
    Rack::Builder.parse_file(path).first
  end
end

