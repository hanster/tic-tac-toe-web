module TicTacToeWeb
  module Ui
    class WebUi
      attr_accessor :board_type, :players_type

      def initialize(board_type, players_type)
        @board_type = board_type
        @players_type = players_type
      end

      def get_board_type
        board_type
      end

      def get_players_type
        players_type
      end

      def prompt_for_move(board, marker)

      end
    end
  end
end
