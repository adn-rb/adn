# encoding: UTF-8

module ADN
  module API
    module Token
      def self.current
        result = ADN.get("/stream/0/token")
        result["data"] unless ADN.has_error?(result)
      end
    end
  end
end
