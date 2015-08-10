require 'tic_tac_toe_core/game_setup'

module TicTacToeWeb
  module Models
    class Setup
      attr_reader :player_options, :board_options

      def initialize
        @player_options = TicTacToeCore::GameSetup::PLAYER_OPTIONS
        @board_options = TicTacToeCore::GameSetup::BOARD_OPTIONS
      end
    end
  end
end
