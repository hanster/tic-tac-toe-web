require 'spec_helper'
require 'tic_tac_toe_web/models/game'
require 'tic_tac_toe_core/game'

module TicTacToeWeb
  module Models
    describe Game do
      let(:player_1) { double("Player").as_null_object }
      let(:player_2) { double("Player").as_null_object }
      let(:players) { [player_1, player_2] }
      let(:ui) { double("Ui").as_null_object }
      let(:board) { TicTacToeCore::Board.create_empty(3) }
      let(:game) { TicTacToeCore::Game.new(board, players, ui) }
      let(:game_model) { Game.new(game, 1, 3) }

      before(:each) do
        allow(game).to receive(:get_current_player_move).and_return(nil)
      end

      it "generates the move url for a new game" do
        expect(game_model.url).to eq("/play?player_option=1&board_option=3&board=---------")
      end

      it "contains the board class for a size three board" do
        expect(game_model.board_class).to eq("size_three")
      end

      it "contains the board class for a four sized board" do
        board = TicTacToeCore::Board.create_empty(4)
        game = TicTacToeCore::Game.new(board, players, ui)
        allow(game).to receive(:get_current_player_move).and_return(nil)
        game_model = Game.new(game, 1, 3)
        expect(game_model.board_class).to eq("size_four")
      end

      it "should have 9 board_panels for a 3x3 game" do
        expect(game_model.board_panels.size).to eq(9)
      end

      it "board_panels which have a url of /play if the position is empty" do
        board_panels = game_model.board_panels
        board_panels.each do |board_panel|
          expect(board_panel.url).to include("/play")
        end
      end

      it "board_panels have url of # if they are taken" do
        game_model = create_game_model_with_board(3, "XXXOOOXXX")
        board_panels = game_model.board_panels
        board_panels.each do |board_panel|
          expect(board_panel.url).to eq("#")
        end
      end

      it "has a status of game over when there is a winner" do
        game_model = create_game_model_with_board(3, "XXX------")
        expect(game_model.status).to eq("Game Over\n\nX wins!")
      end

      it "has a status of tie when the game is a tie" do
        game_model = create_game_model_with_board(3, "XOXOXOOXO")
        expect(game_model.status).to eq("Game Over\n\nIt's a draw!")
      end

      it "has a status of the current player turn" do
        expect(game_model.status).to include("Turn = Player")
      end

      def create_game_model_with_board(size, initial)
        board = TicTacToeCore::Board.new(size,initial.split(''))
        game = TicTacToeCore::Game.new(board, players, ui)
        allow(game).to receive(:get_current_player_move).and_return(nil)
        Game.new(game, 1, 3)
      end
    end
  end
end
