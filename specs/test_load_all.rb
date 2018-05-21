# Run pry -r <path/to/this/file>
require 'rack/test'
include Rack::Test::Methods

require_relative '../init.rb'

def app
  TalkUp::App
end

DATA = {}
DATA[:accounts] = YAML.safe_load File.read('specs/seeds/account_seeds.yml')
