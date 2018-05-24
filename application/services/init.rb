folders = %w[account issue]

folders.each do |floder|
  require_relative "#{floder}/init.rb"
end