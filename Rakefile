%w{ find rake/testtask}.each { |lib| require lib }

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
end

desc "Run tests in a loop using kicker (>= 3.0.0pre1)"
task :kicker do
  exec 'kicker --no-notification -r ruby -e "clear && rake" spec lib'
end
