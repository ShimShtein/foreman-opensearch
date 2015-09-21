# Tasks
namespace :foreman_opensearch do
  namespace :example do
    desc 'Example Task'
    task task: :environment do
      # Task goes here
    end
  end
end

# Tests
namespace :test do
  desc 'Test ForemanOpensearch'
  Rake::TestTask.new(:foreman_opensearch) do |t|
    test_dir = File.join(File.dirname(__FILE__), '../..', 'test')
    t.libs << ['test', test_dir]
    t.pattern = "#{test_dir}/**/*_test.rb"
    t.verbose = true
  end
end

namespace :foreman_opensearch do
  task :rubocop do
    begin
      require 'rubocop/rake_task'
      RuboCop::RakeTask.new(:rubocop_foreman_opensearch) do |task|
        task.patterns = ["#{ForemanOpensearch::Engine.root}/app/**/*.rb",
                         "#{ForemanOpensearch::Engine.root}/lib/**/*.rb",
                         "#{ForemanOpensearch::Engine.root}/test/**/*.rb"]
      end
    rescue
      puts 'Rubocop not loaded.'
    end

    Rake::Task['rubocop_foreman_opensearch'].invoke
  end
end

Rake::Task[:test].enhance do
  Rake::Task['test:foreman_opensearch'].invoke
end

load 'tasks/jenkins.rake'
if Rake::Task.task_defined?(:'jenkins:unit')
  Rake::Task['jenkins:unit'].enhance do
    Rake::Task['test:foreman_opensearch'].invoke
    Rake::Task['foreman_opensearch:rubocop'].invoke
  end
end
