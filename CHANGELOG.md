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