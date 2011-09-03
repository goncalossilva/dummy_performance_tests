require File.expand_path("../test_helper", File.dirname(__FILE__))

class DummyPerformanceGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Dummy::Generators::PerformanceTestsGenerator
  arguments []

  setup :create_test_application
  teardown :clean_tmp

  def test_dummy_generates_performance_tests
    Dummy::Generators::DataGenerator.start
    run_generator
    assert true
  end
end

