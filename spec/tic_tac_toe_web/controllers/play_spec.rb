require 'spec_helper'
require 'tic_tac_toe_web/controllers/play'

module TicTacToeWeb
  module Controllers
    describe Play do
      def app
        Play.new
      end

      it "renders a screen that has one move" do
        get('/',
            { "player_options" => 1,
              "board_option" => 3,
              "board" => "---------",
              "move" => "1" }
           )
        expect(last_response.status).to eq 200
        expect(last_response.body).to include("X--------")
      end
    end
  end
end
