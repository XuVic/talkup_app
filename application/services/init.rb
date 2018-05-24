folders = %w[account]

folders.each do |floder|
  require_relative "#{floder}/init.rb"
end