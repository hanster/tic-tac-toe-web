require 'slim'
require 'tilt'
require 'rack'

module TicTacToeWeb
  module RenderingHelpers
    def render(path, resp_code=200)
      Rack::Response.new Tilt.new(find_template(path)).render(self), resp_code
    end

    def find_template(path)
      template = File.join('lib/tic_tac_toe_web/views', path)
      raise NotFoundError, 'template not found' unless File.exists? template
      template
    end
  end

  class NotFoundError < StandardError
    def call(env)
      Rack::Response.new message, 404
    end
  end
end
