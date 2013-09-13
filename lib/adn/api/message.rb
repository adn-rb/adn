# encoding: UTF-8

module ADN
  module API
    module Message
      def self.create(channel_id, params)
        ADN::API.post("#{ADN::API_ENDPOINT_CHANNELS}/#{channel_id}/messages", params)
      end

      def self.retrieve(channel_id, message_id)
        ADN::API.get("#{ADN::API_ENDPOINT_CHANNELS}/#{channel_id}/messages/#{message_id}")
      end

      def self.by_id(channel_id, message_id)
        self.retrieve(channel_id, message_id)
      end

      def self.delete(channel_id, message_id)
        ADN::API.delete("#{ADN::API_ENDPOINT_CHANNELS}/#{channel_id}/messages/#{message_id}")
      end
    end
  end
end
