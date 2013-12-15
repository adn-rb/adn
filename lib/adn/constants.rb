# encoding: UTF-8

require 'net/https'

module ADN
  API_HOST = "alpha-api.app.net"
  API_ENDPOINT = "/stream/0"
  API_ENDPOINT_POSTS = "#{API_ENDPOINT}/posts"
  API_ENDPOINT_USERS = "#{API_ENDPOINT}/users"
  API_ENDPOINT_TOKEN = "#{API_ENDPOINT}/token"
  API_ENDPOINT_CHANNELS = "#{API_ENDPOINT}/channels"
  API_ENDPOINT_FILES = "#{API_ENDPOINT}/files"
  HTTP = Net::HTTP.new(API_HOST, 443)

  HTTP_ERROR = 400

  HTTP.use_ssl = true
end
