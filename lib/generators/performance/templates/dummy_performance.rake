namespace :dummy do
  namespace :performance do
    namespace :test do
      desc "Run all dummy performance tests"
      task :all do
        Dir["<%= options.output_folder %>/performance/*_test.rb"].each do |test_path|
          system "ruby #{test_path}"
        end
      end
    end
  end
end
