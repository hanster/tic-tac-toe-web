module TicTacToeWeb
  module Models
    class Game
      attr_reader :game, :board, :board_panels

      PLAYER_TURN_TEXT = "Turn = Player"
      GAME_OVER_TEXT = "Game Over\n\n"
      WINNER_MESSAGE = "wins!"
      DRAW_MESSAGE = "It's a draw!"
      PLAY_URL = "/play?"
      CLASS_SIZE_3 = "size_three"
      CLASS_SIZE_4 = "size_four"

      def initialize(game, player_type, board_type)
        @game = game
        @board = game.board
        @player_type = player_type
        @board_type = board_type
        @board_panels = create_board_panels
      end

      def status
        get_status_message(board, game.current_player_marker)
      end

      def url
        PLAY_URL + Rack::Utils.build_query(params)
      end

      def board_class
        return CLASS_SIZE_3 if game.board.size == 3
        CLASS_SIZE_4
      end

      private

      attr_reader :player_type, :board_type

      def params
        { "player_option" => player_type,
          "board_option" => board_type,
          "board" => board.positions.join(''),
        }
      end

      def get_status_message(board, marker)
        if board.finished?
          GAME_OVER_TEXT + end_game_message(board)
        else
          "#{PLAYER_TURN_TEXT} #{marker}"
        end
      end

      def end_game_message(board)
        if board.tie?
          DRAW_MESSAGE
        else
          "#{board.winner} #{WINNER_MESSAGE}"
        end
      end

      def create_board_panels
        board_panels = []
        board.positions.each_index do |index|
          board_panels << create_board_panel(board, index)
        end
        board_panels
      end

      def create_board_panel(board, index)
        if board.is_available?(index)
          offset_index = index + 1
          click_url = url + "&move=" + offset_index.to_s
          click_url = "#" if board.finished?
          BoardPanel.new(click_url, offset_index.to_s)
        else
          BoardPanel.new("#", board.marker_at(index))
        end
      end
    end

    class BoardPanel
      attr_reader :url ,:text, :css_class

      def initialize(url, text)
        @url = url
        @text = text
        @css_class = is_text_marker? ? text : 'move'
      end

      private

      def is_text_marker?
        text == 'X' || text == 'O'
      end
    end
  end
end
