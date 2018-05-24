folders = %w[representers views services controllers]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
