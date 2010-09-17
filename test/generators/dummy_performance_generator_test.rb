require File.expand_path("../test_helper", File.dirname(__FILE__))

class DummyPerformanceGeneratorTest < Rails::Generators::TestCase
  destination File.join(Rails.root)
  tests Dummy::Generators::PerformanceGenerator
  arguments []

  setup :create_test_application
  teardown :clean_tmp

  test "dummy generates performance tests" do
    run_generator
    assert true
  end
end

