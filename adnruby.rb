require 'net/https'
require 'uri'
require 'json'

API = "alpha-api.app.net"

module ADN
  def self.token=(token)
    @token = token
  end

  def self.token
    @token
  end

  class User
    def self.retrieve(user_id)
      ADN.get("/stream/0/users/#{user_id}")
    end

    def self.follow(user_id)
      ADN.post("/stream/0/users/#{user_id}/follow")
    end

    def self.unfollow(user_id)
      ADN.delete("/stream/0/users/#{user_id}/follow")
    end

    def self.following(user_id)
      ADN.get("/stream/0/users/#{user_id}/following")
    end

    def self.followers(user_id)
      ADN.get("/stream/0/users/#{user_id}/followers")
    end

    def self.mute(user_id)
      ADN.post("/stream/0/users/#{user_id}/mute")
    end

    def self.unmute(user_id)
      ADN.delete("/stream/0/users/#{user_id}/mute")
    end

    def self.mute_list
      ADN.get("/stream/0/users/me/muted")
    end

    # def self.posts(user_id)
    #   ADN::Post.by_user(user_id)
    # end

    # def self.mentions(user_id)
    #   ADN::Post.mentioning_user(user_id)
    # end


  end

  class Post
    def self.new(params)
      ADN.post("/stream/0/posts", params)
    end

    def self.retrieve(post_id)
      ADN.get("/stream/0/posts/#{post_id}")
    end

    def self.by_id(post_id)
      self.retrieve(post_id)
    end

    def self.delete(post_id)
      ADN.delete("/stream/0/posts/#{post_id}")
    end

    def self.replies(post_id, params = nil)
      ADN.get("/stream/0/posts/#{post_id}/replies", params)
    end

    def self.by_user(user_id, params = nil)
      ADN.get("/stream/0/users/#{user_id}/posts", params)
    end

    def self.mentioning_user(user_id, params = nil)
      ADN.get("/stream/0/users/#{user_id}/mentions", params)
    end

    def self.stream(params = nil)
      ADN.get("/stream/0/posts/stream", params)
    end

    def self.global_stream(params = nil)
      ADN.get("/stream/0/posts/stream/global", params)
    end

    def self.by_hashtag(hashtag, params = nil)
      ADN.get("/stream/0/posts/tag/#{hashtag}", params)
    end

  end

  class Stream
    # Not Yet Implemented
    # https://github.com/appdotnet/api-spec/blob/master/resources/streams.md
  end

  class Subscription
    # Not Yet Implemented
    # https://github.com/appdotnet/api-spec/blob/master/resources/subscriptions.md
  end

  class Filter
    # Not Yet Implemented
    # https://github.com/appdotnet/api-spec/blob/master/resources/filters.md
  end

  class Token
    def self.current
      ADN.get("/stream/0/token")
    end
  end

  def self.get(url, params = nil)
    http = Net::HTTP.new(API, 443)
    http.use_ssl = true

    get_url = params.nil? ? url : "#{url}?#{URI.encode_www_form(params)}"
    request = Net::HTTP::Get.new(get_url)
    request.add_field("Authorization", "Bearer #{ADN.token}")
    response = http.request(request)
    return JSON.parse(response.body)
  end

  def self.post(url, params = nil)
    http = Net::HTTP.new(API, 443)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request.set_form_data(params) if params
    request.add_field("Authorization", "Bearer #{ADN.token}")
    response = http.request(request)
    return JSON.parse(response.body)
  end

  def self.put(url, params = nil)
    http = Net::HTTP.new(API, 443)
    http.use_ssl = true

    request = Net::HTTP::Put.new(url)
    request.set_form_data(params) if params
    request.add_field("Authorization", "Bearer #{ADN.token}")
    response = http.request(request)
    return JSON.parse(response.body)
  end

  def self.delete(url, params = nil)
    http = Net::HTTP.new(API, 443)
    http.use_ssl = true

    request = Net::HTTP::Delete.new(url)
    request.add_field("Authorization", "Bearer #{ADN.token}")
    response = http.request(request)
    return JSON.parse(response.body)
  end
end
