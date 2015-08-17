module TicTacToeWeb
  class GameUpdater
    def initialize(game)
      @game = game
    end

    def next_game_state
      while game.running? && move_available?
        game.make_move(current_move)
      end
      game
    end

    private

    def move_available?
      @current_move = game.get_current_player_move
      if current_move
        true
      else
        false
      end
    end

    attr_reader :game, :current_move
  end
end
