require 'roar'
require 'roar/json'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end

require_relative './policies/init.rb'