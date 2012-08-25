ADNRuby
=======

A Ruby library for App.net by [@kishyr](https://alpha.app.net/kishyr).  

This library follows the current [App.net API Spec](https://github.com/appdotnet/api-spec) (as at 25 August 2012) with easy-to-use and understand methods that returns the data back as a `Hash`.  

### Installation

Simply add ADNRuby to your Gemfile:

`gem "adnruby"`

Or you can install ADNRuby directly from rubygems.org:

`gem install adnruby`


### Usage
For API calls that accept parameters described in the App.net API Spec, simply pass them as a dictionary to the method.  

```ruby
  require 'adnruby'

  ADN.token = "your App.net OAuth-token here."

  # Users
  user_details = ADN::User.retrieve "me"
  follow_data = ADN::User.follow "kishyr"
  # etc...

  # Posts
  params = { text: "This is an example post on App.net!", reply_to: 189018 }
  post_data = ADN::Post.new(params)

  # User's stream
  user_stream = ADN::Post.stream({ count: 10, include_replies: "true" })

  # Global stream
  global_stream = ADN::Post.global_stream
```

A complete method list will be available on this README soon, but in the meantime you can browse all API methods in `lib/adnruby.rb`.

---

### License

**ADNRuby** is licensed under the MIT License and is Copyright (c) 2012 Kishyr Ramdial.  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
