$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'minitest/spec'
require 'minitest/autorun'
require 'pry'
require 'pry-rescue/minitest'

require 'brainyplex'

