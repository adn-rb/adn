# encoding: UTF-8

require 'net/https'

module ADN
  API_HOST = "alpha-api.app.net"
  API_ENDPOINT = "/stream/0"
  API_ENDPOINT_POSTS = "#{API_ENDPOINT}/posts"
  API_ENDPOINT_STREAM = "#{API_ENDPOINT_POSTS}/stream"
  API_ENDPOINT_STREAM_GLOBAL = "#{API_ENDPOINT_POSTS}/stream/global"
  API_ENDPOINT_STREAM_UNIFIED = "#{API_ENDPOINT_POSTS}/stream/unified"
  API_ENDPOINT_TAG= "#{API_ENDPOINT}/posts/tag"
  API_ENDPOINT_TOKEN = "#{API_ENDPOINT}/token"
  API_ENDPOINT_USERS = "#{API_ENDPOINT}/users"
  HTTP = Net::HTTP.new(API_HOST, 443)

  HTTP.use_ssl = true
end
