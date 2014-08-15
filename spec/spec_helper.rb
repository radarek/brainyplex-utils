if %w(1 true).include?(ENV['COVERAGE'])
  require 'simplecov'
  SimpleCov.start
end

require "pry"
require "fakefs/safe"
require "growl"

if %w(1 true).include?(ENV['PRY_RESCUE'])
  require 'pry-rescue/rspec'
end

require "brainyplex-utils"

Dir[__dir__ + "/support/**/*.rb"].each { |f| require_relative f }

# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.filter_run :focus
  config.filter_run_excluding broken: true
  config.run_all_when_everything_filtered = true

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 5

  config.order = :random

  Kernel.srand config.seed

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  config.mock_with :rspec do |mocks|
    mocks.syntax = :expect
    mocks.verify_partial_doubles = true
  end

  config.include FixtureHelpers
end

