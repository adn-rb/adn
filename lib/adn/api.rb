# encoding: UTF-8

require 'delegate'

%w{filter post stream subscription token user}.each do |f|
  require_relative "api/#{f}"
end

module ADN
  module API
    class Response < SimpleDelegator
      def has_error?
        has_key?("error")
      end

      def invalid_request?
        has_error? && has_value("invalid_request")
      end

      def unauthorized_client?
        has_error && has_value("unauthorized_client")
      end

      def access_denied?
        has_error? && has_value("access_denied")
      end

      def unsupported_response_type?
        has_error? && has_value("unsupported_response_type")
      end

      def invalid_scope?
        has_error? && has_value("invalid_scope")
      end

      def server_error?
        has_error? && has_value("server_error")
      end

      def temporarily_unavailable?
        has_error? && has_value("temporarily_unavailable")
      end
    end

    def self.get_response(request)
      request.add_field("Authorization", "Bearer #{ADN.token}")
      response = ADN::HTTP.request(request)
      Response.new(JSON.parse(response.body))
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
end
