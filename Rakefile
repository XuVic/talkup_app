require 'rake/testtask'

desc 'Test api_spec only'
task :api_spec do
  sh 'ruby specs/api_spec.rb'
end

desc 'Run all tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'specs/*_spec.rb'
  t.warning = false
end

desc 'Run application console(pry)'
task :console do
  sh 'pry -r ./specs/test_load_all'
end
