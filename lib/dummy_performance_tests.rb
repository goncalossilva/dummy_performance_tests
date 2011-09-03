require "rubygems"
require "dummy"
require "generators/common"
require "generators/performance/performance_tests_generator"

module Dummy
  module Generators
    class MissingDummyfile < RuntimeError; end
  end
end
