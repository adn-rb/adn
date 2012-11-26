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