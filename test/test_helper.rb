$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'nonsensor'

require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(color: true)]
