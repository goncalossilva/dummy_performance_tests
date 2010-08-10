module Dummy
  module Generators
    class PerformanceTestsGenerator < Rails::Generators::Base  
      include Dummy::Generators::Common
          
      def self.source_root
        @source_root ||= File.expand_path("../templates", __FILE__)
      end
      
      class_option :output_folder, :type => :string, :default => "test/dummy",
                  :desc => "Dummy output folder, performance/ will be used when storing the resulting performance tests."

      def install_performance_tests
        check_dummyfile
        generate_and_write_performance_tests
        copy_rake_file
      end

    private
      def check_dummyfile
        if not File.exists? "#{options.output_folder}/Dummyfile"
          raise MissingDummyfile, "Could not find the Dummyfile. Did you forget to generate dummy data/routes or specified a different directory?"
        end
          
        end
    
      def generate_and_write_performance_tests 
        template "test_helper.rb", "#{options.output_folder}/performance/test_helper.rb"
               
        Dir["#{options.output_folder}/routes/*.yml"].each do |file|
          @routes = YAML.load_file file
          @model_name = File.basename(file).chomp(File.extname(file))
          
          template "dummy_performance_test.rb", 
            "#{options.output_folder}/performance/#{@model_name}_performance_test.rb"
        end
      end
      
      def copy_rake_file
        template "dummy_performance.rake", "lib/tasks/dummy_performance.rake"
      end
    end
  end
end

