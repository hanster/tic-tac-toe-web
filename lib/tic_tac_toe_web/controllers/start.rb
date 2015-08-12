require 'tic_tac_toe_web/rendering_helpers'
require 'tic_tac_toe_web/models/start'

module TicTacToeWeb
  module Controllers
    class Start
      include RenderingHelpers

      attr_reader :message, :game_model

      def initialize
        @message = "Start message"
      end

      def call(env)
        params = extract_params(env)
        @start = Models::Start.new(params)
        @game_model = @start.game_model
        render("play.slim")
      end

      private

      def extract_params(env)
        Rack::Utils.parse_query(env["QUERY_STRING"])
      end
    end
  end
end
