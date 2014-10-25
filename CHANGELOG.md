### Changelog

* **Version 0.3.10** (25 October 2014)
  * Bugfix: Construct user object using data property
* **Version 0.3.9** (25 October 2014)
  * Bugfix: Use of ADN.post/delete changed to ADN::API.post/delete
* **Version 0.3.8** (31 December 2013)
  * Removed all style violations (cane --no-doc)
  * Added files to broadcast builder
* **Version 0.3.7** (15 December 2013)
  * Recipes now use the builder pattern
  * Basic file functionality
* **Version 0.3.6** (11 December 2013)
  * Added recipe for easy broadcast creation
* **Version 0.3.5** (23 October 2012)
  * Added the unified stream
* **Version 0.3.1** (28 August 2012)
  * Fixed naming conflict.
* **Version 0.3** (28 August 2012)
  * Now includes a Post class that describes each post along with a bunch of new methods of accessing a post's replies and the post's original post.
  * Users methods that return user details (follow, unfollow, following, followers, mute, unmute, mute_list) will now return either a User object back, or an array of User objects.
  * Similarly, User methods that return post details (posts, mentions, stream) will return a Post object, or an array of Post objects.
  * To accomplish all this, I've had to change the module structure which will break existing code if you've relied on the modules to access any data. Basically, all modules begin with ADN::API:: now (eg. ADN::API::Post, ADN::API::User).
* **Version 0.2** (27 August 2012)
  * Changed all existing classes to modules and introduced the User class for easily accessing user details.
* **Version 0.1** (26 August 2012)
  * Really basic functionality for all existing App.new API methods as per the spec.
