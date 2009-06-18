require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

task :default => :create_reports

task :create_reports do
  require 'obd_reports'
end

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "odb_reports"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end
