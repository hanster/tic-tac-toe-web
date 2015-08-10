require 'tic_tac_toe_web/rendering_helpers'
require 'tic_tac_toe_web/models/setup'

module TicTacToeWeb
  module Controllers
    class Setup
      include RenderingHelpers

      attr_reader :setup

      def initialize
        @setup = Models::Setup.new
      end

      def call(env)
        render("setup.slim")
      end
    end
  end
end
