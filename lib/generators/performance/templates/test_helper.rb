ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../../../config/environment', __FILE__)

require 'test/unit'
require 'active_support/core_ext/kernel/requires'
require 'active_support/test_case'
require 'active_support/testing/performance'
require 'action_dispatch/testing/integration'

# most of the code below came from rails/test_helper,
# it can't be used directly since the fixture's path is hard coded
warn "Your Rails environment is not running in test mode!" unless Rails.env.test?

if defined?(ActiveRecord)
  require 'active_record/test_case'

  class ActiveSupport::TestCase
    include ActiveRecord::TestFixtures
    self.fixture_path = File.expand_path('../../data', __FILE__)
    
    fixtures :all
  end

  def create_fixtures(*table_names, &block)
    Fixtures.create_fixtures(ActiveSupport::TestCase.fixture_path, table_names, {}, &block)
  end
end

class ActionDispatch::IntegrationTest
  setup do
    @routes = Rails.application.routes
  end
end

module ActiveSupport
  module Testing
    module Performance
      DEFAULTS =
        { :benchmark => false,
          :runs => 1,
          :min_percent => 0.001,
          :metrics => [:process_time], # TODO: add :memory when ruby-prof doesn't generally fail
          :formats => [:graph_yaml, :call_stack],
          :output => "<%= options.output_folder %>/results/" }.freeze
          
      class Profiler < Performer
        protected
        
        def output_filename(printer_class)
          suffix =
            case printer_class.name.demodulize
              when 'FlatPrinter';                 'flat.txt'
              when 'FlatPrinterWithLineNumbers';  'flat_line_numbers.txt'
              when 'GraphPrinter';                'graph.txt'
              when 'GraphHtmlPrinter';            'graph.html'
              when 'GraphYamlPrinter';            'graph.yml'
              when 'CallTreePrinter';             'tree.txt'
              when 'CallStackPrinter';            'stack.html'
              when 'DotPrinter';                  'graph.dot'
              else printer_class.name.sub(/Printer$/, '').underscore
            end

          "#{super()}_#{suffix}"
        end
      end
    end
  end
end
