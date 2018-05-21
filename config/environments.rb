require 'roda'
require 'econfig'
require 'rack/ssl-enforcer'

module TalkUp
  # Configuration for the API
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'

    configure :development, :test do
      require 'rack/test'
      include Rack::Test::Methods
      # Allows running reload! in pry to restart entire app
      def self.reload!
        exec 'pry -r ./specs/test_load_all'
      end
    end
  end
end
