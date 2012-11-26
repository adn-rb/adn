source :rubygems
gemspec

group :test do
  gem 'rake'
  gem 'minitest', '~> 4.1'
  gem 'kicker', '>= 3.0.0pre1'

  case RUBY_PLATFORM
  when /darwin/
    gem 'rb-fsevent'
  when /linux/
    gem 'rb-inotify'
  end
end