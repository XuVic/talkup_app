folders = %w[representers views form services controllers ]
folders.each do |folder|
  require_relative "#{folder}/init.rb"
end
