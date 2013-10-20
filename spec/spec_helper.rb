$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
if %w(1 true).include?(ENV['COVERAGE'])
  require 'simplecov'
  SimpleCov.start
end

require 'minitest/spec'
require 'minitest/autorun'
require 'pry'
require 'pry-rescue/minitest'

require 'brainyplex'

