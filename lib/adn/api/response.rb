# encoding: UTF-8

require 'delegate'

module ADN
  module API
    class Response < SimpleDelegator
      def has_error?
        self['meta'].nil? || self['meta']['code'].nil? || self['meta']['code'] >= 400
      end
    end
  end
end
