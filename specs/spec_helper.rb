ENV['RACK_ENV'] = 'test'

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'

require_relative 'test_load_all'

DATA = {}
DATA[:accounts] = YAML.safe_load File.read('specs/seeds/account_seeds.yml')
