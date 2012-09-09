# encoding: UTF-8

module ADN
  module API
    module Token
      def self.current
        result = ADN::API.get(ADN::API_ENDPOINT_TOKEN)
        result["data"] unless result.has_error?
      end
    end
  end
end
