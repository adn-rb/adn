# encoding: UTF-8

module ADN
  module API
    module Message
      def self.create(channel_id, params)
        path = "/#{channel_id}/messages"

        ADN::API.post(ADN::API_ENDPOINT_CHANNELS + path, params)
      end

      def self.retrieve(channel_id, message_id)
        path = "/#{channel_id}/messages/#{message_id}"

        ADN::API.get(ADN::API_ENDPOINT_CHANNELS + path)
      end

      def self.by_id(channel_id, message_id)
        self.retrieve(channel_id, message_id)
      end

      def self.delete(channel_id, message_id)
        path = "/#{channel_id}/messages/#{message_id}"

        ADN::API.delete(ADN::API_ENDPOINT_CHANNELS + path)
      end
    end
  end
end
