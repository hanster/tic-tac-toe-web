require 'tic_tac_toe_web/rendering_helpers'
require 'tic_tac_toe_core/game_setup'
require 'tic_tac_toe_core/board'
require 'tic_tac_toe_web/models/game'
require 'tic_tac_toe_web/web_ui'

module TicTacToeWeb
  module Controllers
    class Play
      include RenderingHelpers

      PLAYERS_OPTION_PARAM = 'player_option'
      BOARD_OPTION_PARAM = 'board_option'
      DEFAULT_PLAYER_OPTION = "1"
      DEFAULT_BOARD_OPTION = "3"

      attr_reader :game_model

      def call(env)
        @params = extract_params(env)
        game = create_base_game(env)
        current_board = extract_board_param.split('')
        board = TicTacToeCore::Board.new(board_type, current_board)
        game.board = board
        game.make_move(params["move"].to_i - 1)
        @game_model = Models::Game.new(game, player_type, board_type)
        render("play.slim")
      end

      private

      attr_reader :params, :player_type, :board_type

      def create_base_game(env)
        @player_type = extract_player_option_param
        @board_type = extract_board_option_param
        TicTacToeCore::GameSetup.new(create_web_ui).build_game
      end

      def create_web_ui
        Ui::WebUi.new(board_type, player_type)
      end

      def extract_board_param
        params.fetch("board", "-" * board_type * board_type)
      end

      def extract_player_option_param
        params.fetch(PLAYERS_OPTION_PARAM, DEFAULT_PLAYER_OPTION).to_i
      end

      def extract_board_option_param
        params.fetch(BOARD_OPTION_PARAM, DEFAULT_BOARD_OPTION).to_i
      end

      def extract_params(env)
        Rack::Utils.parse_query(env["QUERY_STRING"])
      end
    end
  end
end
