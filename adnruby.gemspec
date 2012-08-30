# encoding: UTF-8

require File.expand_path('../lib/adn/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'adnruby'
  s.version     = ADN::VERSION
  s.authors     = ["Kishyr Ramdial", "Dave Goodchild", "Peter Hellberg"]
  s.email       = "kishyr@gmail.com"
  s.description = "A simple and easy to use library to interact with App.net's API"
  s.summary     = "A Ruby library for App.net"
  s.homepage    = "https://github.com/kishyr/ADNRuby"
  s.files       = `git ls-files`.split($\)
  s.test_files  = s.files.grep(%r{^(spec)/})

  s.required_ruby_version = '>= 1.9.3'
end
