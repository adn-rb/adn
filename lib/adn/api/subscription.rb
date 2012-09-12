# encoding: UTF-8

module ADN
  module API
    module Subscription
      # Not Yet Implemented
      # https://github.com/appdotnet/api-spec/
      # blob/master/resources/subscriptions.md
      def self.list
        ADN::API.get("#{ADN::API_ENDPOINT_SUBSCRIPTIONS}")
      end

      def self.create(params)
        ADN::API.post("#{ADN::API_ENDPOINT_SUBSCRIPTIONS}")
      end

      def self.delete(subscription_id)
        ADN::API.delete("#{ADN::API_ENDPOINT_SUBSCRIPTIONS}/#{subscription_id}")
      end
      
      def self.delete_all
        ADN::API.delete("#{ADN::API_ENDPOINT_SUBSCRIPTIONS}")
      end
    end
  end
end
