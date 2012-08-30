require 'find'
require 'rake/testtask'

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
end

begin
  require 'cane/rake_task'

  desc "Run cane to check quality metrics"
  Cane::RakeTask.new(:quality)
rescue LoadError
  # Cane not available, quality task not provided.
end

desc "Run tests in a loop using kicker (>= 3.0.0pre1)"
task :kicker do
  exec 'kicker --no-notification -r ruby -e "clear && rake" spec lib'
end
