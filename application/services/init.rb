folders = %w[account issue comment]

folders.each do |floder|
  require_relative "#{floder}/init.rb"
end