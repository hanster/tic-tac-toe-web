require 'tic_tac_toe_web/controllers/setup'
require 'tic_tac_toe_web/controllers/start'
require 'tic_tac_toe_web/controllers/play'
require 'tilt'
require 'rack'

module TicTacToeWeb
  class App
    ROUTES = [
      { :uri => "/setup", :controller => Controllers::Setup },
      { :uri => "/start", :controller => Controllers::Start },
      { :uri => "/play", :controller => Controllers::Play },
    ]

    def app
      Rack::Builder.new do
        ROUTES.each do |route|
          map route[:uri] do
            run route[:controller].new
          end
        end
      end
    end
  end
end
