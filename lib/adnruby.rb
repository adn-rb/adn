#
# ADNRuby - A simple and easy to use App.net Ruby library
#
# Copyright (c) 2012 Kishyr Ramdial
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

require 'uri'
require 'json'
require 'date'

%w{constants api post user version}.each { |f| require_relative "adn/#{f}" }

module ADN
  
  class ADNError < StandardError; end
  class APIError < StandardError; end

  def self.token=(token)
    @token = token
  end

  def self.token
    @token
  end

  def self.has_error?(hash)
    hash.has_key?("error")
  end
  
  def self.create_collection(data, mode, type)
    mode == "collection" ? data.collect { |t| type.new(t) } : type.new(data)
  end

  private

  def self.get_response(request)
    request.add_field("Authorization", "Bearer #{ADN.token}")
    response = ADN::HTTP.request(request)
    JSON.parse(response.body)
  end

  def self.get(url, params = nil)
    get_url = params.nil? ? url : [url, URL.encode_www_form(params)].join("?")
    self.get_response(Net::HTTP::Get.new(get_url))
  end

  def self.post(url, params = nil)
    request = Net::HTTP::Post.new(url)
    request.set_form_data(params) if params
    self.get_response(request)
  end

  def self.put(url, params = nil)
    request = Net::HTTP::Put.new(url)
    request.set_form_data(params) if params
    self.get_response(request)
  end

  def self.delete(url, params = nil)
    request = Net::HTTP::Delete.new(url)
    self.get_response(request)
  end
end
