# encoding: UTF-8

require 'delegate'

module ADN
  module API
    class Response < SimpleDelegator
      def has_error?
        self['meta'].nil? || self['meta']['code'].nil? || self['meta']['code'] >= HTTP_ERROR
      end
    end
  end
end
