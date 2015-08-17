require 'spec_helper'
require 'tic_tac_toe_web/controllers/start'

module TicTacToeWeb
  module Controllers
    describe Start do
      def app
        Start.new
      end

      let(:hvh_game) { TicTacToeCore::GameSetup::HVH_GAME_TYPE }

      it "renders a screen with a new 3x3 game" do
        get('/', { "player_option" => hvh_game, "board_option" => 3 })
        expect(last_response.status).to eq 200
        (1..9).each do |number|
          expect(last_response.body).to include(number.to_s)
        end
      end

      it "renders a screen wth a new 4x4 game" do
        get('/', { "player_option" => hvh_game, "board_option" => 4 })
        expect(last_response.status).to eq 200
        (1..16).each do |number|
          expect(last_response.body).to include(number.to_s)
        end
      end
    end
  end
end
