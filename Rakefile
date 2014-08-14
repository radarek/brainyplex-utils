require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList["spec/**/*_spec.rb"]
  t.libs << 'spec'
end

desc 'Run tests'
task :default => :test

namespace :dev do
  desc 'Runs console'
  task :c do
    $: << File.dirname(__FILE__) + '/lib'

    require 'pry'
    require 'brainyplex'

    pry
  end
end
