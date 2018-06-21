require 'roda'
require 'econfig'
require 'rack/ssl-enforcer'
require 'rack/session/redis'


module TalkUp
  # Configuration for the API
  class App < Roda
    plugin :environments

    extend Econfig::Shortcut
    Econfig.env = environment.to_s
    Econfig.root = '.'
  end
end
