# encoding: UTF-8

require 'delegate'

module ADN
  module API
    class Response < SimpleDelegator
      def has_error?
        has_key?("error")
      end
    end
  end
end
