# encoding: UTF-8

%w{response filter post stream subscription token user}.each { |f| require_relative "api/#{f}" }

module ADN
  module API
    Error = Class.new StandardError

    class << self
      def perform(request)
        request.add_field("Authorization", "Bearer #{ADN.token}")
        response = JSON.parse ADN::HTTP.request(request).body

        Response.new(response).tap { |r|
          raise ADN::API::Error, r['error'] if r.has_error?
        }
      end
      
      def construct_request(verb = 'get', url)
        verb = verb.capitalize
        Net::HTTP::verb.new(url)
      end

      def get(url, params = nil)
        url = params.nil? ? url : [url, URI.encode_www_form(params)].join("?")
        request = construct_request('get', url)
        perform(request)
      end

      def post(url, params = nil)
        request = construct_request('post', url)
        request.set_form_data(params) if params
        perform(request)
      end

      def put(url, params = nil)
        request = construct_request('put', url)
        request.set_form_data(params) if params
        perform(request)
      end

      def delete(url)
        request = construct_request('delete', url)
        perform(request)
      end
    end
  end
end
