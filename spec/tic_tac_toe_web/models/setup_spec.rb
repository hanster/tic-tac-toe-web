require 'spec_helper'
require 'tic_tac_toe_web/models/setup'
require 'tic_tac_toe_core/game_setup'

module TicTacToeWeb
  module Models
    describe Setup do
      it 'contains the player type options' do
        setup = Setup.new
        expect(setup.player_options).to eq(TicTacToeCore::GameSetup::PLAYER_OPTIONS)
      end

      it 'contains the board type options' do
        setup = Setup.new
        expect(setup.board_options).to eq(TicTacToeCore::GameSetup::BOARD_OPTIONS)
      end
    end
  end
end
