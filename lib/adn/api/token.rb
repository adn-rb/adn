# encoding: UTF-8

module ADN
  module API
    module Token
      def self.current
        result = ADN.get("/stream/0/token")
        result["data"] unless result.has_error?
      end
    end
  end
end
