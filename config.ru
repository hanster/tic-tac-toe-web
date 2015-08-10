$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'tic_tac_toe_web/app'

use Rack::Static, :urls => ["/assets"]
run TicTacToeWeb::App.new.app
