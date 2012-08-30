#!/usr/bin/env rake
require 'find'
require 'rake/testtask'
require 'bundler/gem_tasks'

task :default => :spec

Rake::TestTask.new(:spec) do |t|
  t.test_files = FileList['spec/**/*_spec.rb']
end

desc "Run cane to check quality metrics"
task :quality do
  Bundler.with_clean_env do
    exec 'cane'
  end
end

desc "Run tests in a loop using kicker (>= 3.0.0pre1)"
task :kicker do
  Bundler.with_clean_env do
    exec 'kicker --no-notification -r ruby -e "clear && rake" spec lib'
  end
end
