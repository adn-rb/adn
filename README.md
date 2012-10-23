ADN
===

[![Build Status](https://secure.travis-ci.org/kishyr/ADNRuby.png)](http://travis-ci.org/kishyr/ADNRuby)

A Ruby library for App.net by [@kishyr](https://alpha.app.net/kishyr). 

This library follows the current [App.net API Spec](https://github.com/appdotnet/api-spec) (as at 26 August 2012).  

### Contributors

ADN is brought to you by these very handsome gentlemen:

* Kishyr Ramdial ([@kishyr](https://alpha.app.net/kishyr))
* Dave Goodchild ([@buddhamagnet](https://alpha.app.net/buddhamagnet))
* Peter Hellberg ([@peterhellberg](https://alpha.app.net/peterhellberg))

### Installation

Simply add ADN to your Gemfile:

`gem "adn"`

Or you can install ADN directly from rubygems.org:

`gem install adn`

### Usage
For API calls that accept parameters described in the App.net API Spec, simply pass them as a dictionary to the method.  

```ruby
  require 'adn'

  ADN.token = "your App.net OAuth-token here."

  # TODO: Actually describe the usage of the library
  #       (Should be refactored first)
```

Complete documentation will be available soon, but in the meantime you can browse all API methods in `lib/adnruby.rb`.

### License

**ADN** is licensed under the MIT License and is Copyright (c) 2012 Kishyr Ramdial.  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
