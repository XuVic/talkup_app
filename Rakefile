require 'rake/testtask'

desc 'Test api_spec only'
task :api_spec do
  sh 'ruby specs/api_spec.rb'
end

namespace :spec do 
  desc 'Run all tests'
  task all: %i[spec spec_unit]

  desc 'Run gateway tests'
  Rake::TestTask.new(:api) do |t|
    t.pattern = 'specs/api/*_api.rb'
    t.warning = false
  end

  desc 'Run unit tests'
  Rake::TestTask.new(:unit) do |t|
    t.pattern = 'specs/unit/*_spec.rb'
    t.warning = false
  end
end

desc 'Run application console(pry)'
task :console do
  sh 'pry -r ./specs/test_load_all'
end

