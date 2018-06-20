
require_relative './app.rb'

Dir.glob("#{File.dirname(__FILE__)}/*.rb").each do |file|
  require file
end

require_relative './account/init.rb'
require_relative './issue/init.rb'
require_relative './comment/init.rb'