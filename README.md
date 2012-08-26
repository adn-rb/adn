ADNRuby
=======

A Ruby library for App.net by [@kishyr](https://alpha.app.net/kishyr). 

This library follows the current [App.net API Spec](https://github.com/appdotnet/api-spec) (as at 26 August 2012).  

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

  # The easiest way to access a user's data is by initializing the user as an object
  me = ADN::User.new("me") # Parameter can be "me", an integer user ID, or a username.
  me.id
  me.name
  me.username
  me.counts
  me.cover_image
  me.description
  me.avatar_image
  me.created_at

  me.followers    # => Followers as an Array
  me.following    # => Following as Array
  me.posts        # User's posts as an Array
  me.stream       # User's stream as an Array
  me.mentions     # User's mentions as an Array

  # Follow another user using their username or user ID
  me.follow "anotheruser"  
  me.unfollow 1234

  # Follow another user using their ADN::User object
  another_user = ADN::User.new("anotheruser")
  me.follow another_user
  me.unfollow another_user
  me.mute another_user
  me.unmute another_user
  me.mute_list

  # And access another user's following status relative to yours
  another_user.follows_you
  another_user.is_muted
  another_user.is_following
  # etc ...

  # Alternatively access everying in it's raw return format (converted to a Hash) by accessing the 
  # ADN::Users and ADN::Post module methods

  # Users
  my_details = ADN::Users.by_id "me" 
  another_user = ADN::Users.by_id 1234
  # etc...

  # Posts
  params = { text: "This is an example post on App.net!", reply_to: 189018 }
  post_data = ADN::Post.new(params)

  # User's stream
  user_stream = ADN::Post.stream({ count: 10, include_replies: "true" })

  # Global stream
  global_stream = ADN::Post.global_stream
```

Completed documentation will be available soon, but in the meantime you can browse all API methods in `lib/adnruby.rb`.

---

### License

**ADNRuby** is licensed under the MIT License and is Copyright (c) 2012 Kishyr Ramdial.  

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
