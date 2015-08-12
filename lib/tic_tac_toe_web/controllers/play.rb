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
        game = create_next_game_state
        @game_model = Models::Game.new(game, player_option, board_option)
        render("play.slim")
      end

      private

      attr_reader :params

      def create_next_game_state
        game = create_base_game
        game.board = create_current_board
        game.make_move(params["move"].to_i - 1)
        game
      end

      def create_base_game
        TicTacToeCore::GameSetup.new(create_web_ui).build_game
      end

      def create_web_ui
        Ui::WebUi.new(board_option, player_option)
      end

      def create_current_board
        current_board = extract_board_param.split('')
        TicTacToeCore::Board.new(board_option, current_board)
      end

      def extract_board_param
        params.fetch("board", "-" * board_option * board_option)
      end

      def player_option
        params.fetch(PLAYERS_OPTION_PARAM, DEFAULT_PLAYER_OPTION).to_i
      end

      def board_option
        params.fetch(BOARD_OPTION_PARAM, DEFAULT_BOARD_OPTION).to_i
      end

      def extract_params(env)
        Rack::Utils.parse_query(env["QUERY_STRING"])
      end
    end
  end
end
