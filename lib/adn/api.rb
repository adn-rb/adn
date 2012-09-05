# encoding: UTF-8

%w{filter post stream subscription token user}.each do |f|
  require_relative "api/#{f}"
end

module ADN
  module API
    class Response < Hash
      def has_error?
        has_key?("error")
      end
    end
    
    def self.get_response(request)
      request.add_field("Authorization", "Bearer #{ADN.token}")
      response = ADN::HTTP.request(request)
      response_hash = ADN::API::Response.new
      JSON.parse(response.body).each_pair do |k, v|
        response_hash[k] = v;
      end
      response_hash
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