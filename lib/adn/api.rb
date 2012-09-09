# encoding: UTF-8

%w{response filter post stream subscription token user}.each do |f|
  require_relative "api/#{f}"
end

module ADN
  module API
    class Error < StandardError; end

    class << self
      def perform(request)
        request.add_field("Authorization", "Bearer #{ADN.token}")
        response = JSON.parse ADN::HTTP.request(request).body

        Response.new(response).tap { |r|
          raise ADN::API::Error, r['error'] if r.has_error?
        }
      end

      def get(url, params = nil)
        url = params.nil? ? url : [url, URI.encode_www_form(params)].join("?")
        request = Net::HTTP::Get.new(url)
        perform(request)
      end

      def post(url, params = nil)
        request = Net::HTTP::Post.new(url)
        request.set_form_data(params) if params
        perform(request)
      end

      def put(url, params = nil)
        request = Net::HTTP::Put.new(url)
        request.set_form_data(params) if params
        perform(request)
      end

      def delete(url)
        request = Net::HTTP::Delete.new(url)
        perform(request)
      end
    end
  end
end
