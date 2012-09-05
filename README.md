ADNRuby
=======

A Ruby library for App.net by [@kishyr](https://alpha.app.net/kishyr). 

This library follows the current [App.net API Spec](https://github.com/appdotnet/api-spec) (as at 26 August 2012).  

### Contributors

ADNRuby is brought to you by these very handsome gentlemen:

* Kishyr Ramdial ([@kishyr](https://alpha.app.net/kishyr))
* Dave Goodchild ([@buddhamagnet](https://alpha.app.net/buddhamagnet))
* Peter Hellberg ([@peterhellberg](https://alpha.app.net/peterhellberg))

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

  # TODO: Actually describe the usage of the library
  #       (Should be refactored first)
```

Complete documentation will be available soon, but in the meantime you can browse all API methods in `lib/adnruby.rb`.

### Changelog

* **Version 0.3.1** (28 August 2012)  
  * Fixed naming conflict
* **Version 0.3** (28 August 2012)  
  * Now includes a Post class that describes each post along with a bunch of new methods of accessing a post's replies and the post's original post.  
  * Users methods that return user details (follow, unfollow, following, followers, mute, unmute, mute_list) will now return either a User object back, or an array of User objects.  
  * Similarly, User methods that return post details (posts, mentions, stream) will return a Post object, or an array of Post objects.  
  * To accomplish all this, I've had to change the module structure which will break existing code if you've relied on the modules to access any data. Basically, all modules begin with ADN::API:: now (eg. ADN::API::Post, ADN::API::User).  
* **Version 0.2** (27 August 2012)  
  * Changed all existing classes to modules and introduced the User class for easily accessing user details
* **Version 0.1** (26 August 2012)  
  * Really basic functionality for all existing App.new API methods as per the spec.

---

### License

**ADNRuby** is licensed under the MIT License and is Copyright (c) 2012 Kishyr Ramdial.  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
