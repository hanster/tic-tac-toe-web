module TicTacToeWeb
  module Controllers
    class GameHelper
      def create_base_game(env)
        @player_type = extract_player_option_param
        @board_type = extract_board_option_param
        TicTacToeCore::GameSetup.new(create_web_ui).build_game
      end

      def create_web_ui
        Ui::WebUi.new(board_type, player_type)
      end
    end
  end
end
