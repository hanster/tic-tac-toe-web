require 'spec_helper'
require 'tic_tac_toe_core/game_setup'
require 'tic_tac_toe_web/controllers/setup'

module TicTacToeWeb
  module Controllers
    describe Setup do
      let(:player_options) { TicTacToeCore::GameSetup::PLAYER_OPTIONS }
      let(:board_options) { TicTacToeCore::GameSetup::BOARD_OPTIONS }
      def app
        Setup.new
      end

      it "returns a response with the player types" do
        get '/'
        player_options.each do |key, value|
          expect(last_response.body).to include(value)
        end
      end

      it "returns a response with the board types" do
        get '/'
        board_options.each do |key, value|
          expect(last_response.body).to include(value)
        end
      end
    end
  end
end
