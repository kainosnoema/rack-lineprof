require 'rblineprof'
require 'term/ansicolor'

module Rack
  class Lineprof

    autoload :Sample, 'rack/lineprof/sample'
    autoload :Source, 'rack/lineprof/source'

    CONTEXT  = 0
    NOMINAL  = 1
    WARNING  = 2
    CRITICAL = 3

    attr_reader :app, :options

    def initialize app, options = {}
      @app, @options = app, options
    end

    def call env
      request = Rack::Request.new env
      matcher = request.params['lineprof']

      return @app.call env unless matcher

      response = nil
      profile = lineprof(%r{#{matcher}}) { response = @app.call env }

      puts Term::ANSIColor.blue("\n[Rack::Lineprof] #{'=' * 63}") + "\n\n" +
           format_profile(profile) + "\n"

      response
    end

    def format_profile profile
      sources = profile.map do |filename, samples|
        Source.new filename, samples, options
      end

      sources.map(&:format).compact.join "\n"
    end

  end
end
