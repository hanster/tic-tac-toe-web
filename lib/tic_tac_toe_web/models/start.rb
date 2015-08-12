require 'tic_tac_toe_core/game_setup'
require 'tic_tac_toe_web/models/game'
require 'tic_tac_toe_web/web_ui'

module TicTacToeWeb
  module Models
    class Start
      PLAYERS_OPTION_PARAM = 'player_option'
      BOARD_OPTION_PARAM = 'board_option'
      DEFAULT_PLAYER_OPTION = "1"
      DEFAULT_BOARD_OPTION = "3"

      attr_reader :core_game, :params, :player_type, :board_type

      def initialize(params)
        @params = params
        @player_type = extract_player_option_param
        @board_type = extract_board_option_param
        @core_game = create_game
      end

      def game_model
        Game.new(core_game, player_type, board_type)
      end

      private

      def create_game
        TicTacToeCore::GameSetup.new(create_web_ui).build_game
      end

      def create_web_ui
        Ui::WebUi.new(board_type, player_type)
      end

      def extract_player_option_param
        params.fetch(PLAYERS_OPTION_PARAM, DEFAULT_PLAYER_OPTION).to_i
      end

      def extract_board_option_param
        params.fetch(BOARD_OPTION_PARAM, DEFAULT_BOARD_OPTION).to_i
      end
    end
  end
end
