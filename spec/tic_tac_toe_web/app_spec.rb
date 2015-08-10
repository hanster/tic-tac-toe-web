require 'spec_helper'
require 'tic_tac_toe_web/app.rb'

module TicTacToeWeb
  describe App do
    it "responds to /setup" do
      get '/setup'
      expect(last_response.status).to eq 200
    end

    it "responds to /start"do
      get '/start'
      expect(last_response.status).to eq 200
    end

    it "responds to /play" do
      get '/play'
      expect(last_response.status).to eq 200
    end

    it "returns a 404 when page not found" do
      get '/does_not_exist'
      expect(last_response.status).to eq 404
    end
  end
end
