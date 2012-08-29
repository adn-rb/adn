# encoding: UTF-8

require 'minitest/spec'
require 'minitest/autorun'

begin
  require 'minitest/pride'
rescue LoadError
  puts "Install the minitest gem if you want colored output"
end

require "find"

%w{./lib}.each do |load_path|
  Find.find(load_path) { |f| require f if f.match(/\.rb$/) }
end

def arg(m, k = ADN, &b)
  k.stub(m,->(a){a}, &b)
end

def args(m, k = ADN, &b)
  k.stub(m,->(*a){a}, &b)
end
