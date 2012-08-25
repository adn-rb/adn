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
