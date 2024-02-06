require 'rubocop/rake_task'

task default: %w[lint run]

RuboCop::RakeTask.new(:lint) do |task|
  task.patterns = ['lib/**/*.rb', 'test/**/*.rb']
  task.fail_on_error = false
end

task :run do
  ruby 'lib/game.rb'
end

# task :test do
#   ruby 'test/cool_program_test.rb'
# end