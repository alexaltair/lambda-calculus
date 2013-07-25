require 'rspec'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new(:spec)

task :test => :spec

desc "Run specs as default activity."
task :default => :spec
# Check the RDoc for RakeTask for various options that you can optionally pass into the task definition.
# https://github.com/rspec/rspec-core/blob/master/lib/rspec/core/rake_task.rb