require 'spec_helper'
require 'tic_tac_toe_web/game_updater'

RSpec.describe TicTacToeWeb::GameUpdater do
  let(:board) { instance_double('Board') }
  let(:players) { [] }
  let(:ui) { instance_double('UI') }

  it "doesn't do any updates if the current player doesn't have a move" do
    game = object_double(TicTacToeCore::Game.new(board, players, ui),
                         :running? => true,
                         :get_current_player_move => nil,
                         :make_move => nil)
    expect(game).to receive(:get_current_player_move)
    expect(game).to_not receive(:make_move)

    described_class.new(game).next_game_state
  end

  it "makes moves until the current player doesn't provide one" do
    game = object_double(TicTacToeCore::Game.new(board, players, ui),
                         :running? => true,
                         :get_current_player_move => nil,
                         :make_move => nil)
    allow(game).to receive(:get_current_player_move).and_return(5, 6, nil)
    expect(game).to receive(:get_current_player_move).exactly(3)
    expect(game).to receive(:make_move).twice

    described_class.new(game).next_game_state
  end

  it "doesn't do any updates if the game is over" do
    game = object_double(TicTacToeCore::Game.new(board, players, ui),
                         :running? => false,
                         :get_current_player_move => nil,
                         :make_move => nil)

    expect(game).to_not receive(:get_current_player_move)
    expect(game).to_not receive(:make_move)

    described_class.new(game).next_game_state
  end
end
