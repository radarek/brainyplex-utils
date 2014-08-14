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
require 'fakefs/safe'

if %w(1 true).include?(ENV['PRY_RESCUE'])
  require 'pry-rescue/minitest'
end

require 'brainyplex'

class MiniTest::Spec
  def fixture(file_path, format)
    data = File.read(File.expand_path(__dir__ + '/fixtures/' + file_path))
    case format
      when :binary      then return data
      when :json        then return JSON(data)
      else              raise "Unknown fixture format: #{format}"
    end
  end
end
