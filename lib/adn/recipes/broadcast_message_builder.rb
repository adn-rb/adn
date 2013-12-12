# encoding: UTF-8

module ADN
  module Recipes
    class BroadcastMessageBuilder
      attr_accessor(
        :headline, :text, :read_more_link, :channel_id
      )

      def annotations
        annotations = [
          {
            type: 'net.app.core.broadcast.message.metadata',
            value: {
              subject: self.headline
            }
          }
        ]

        if self.read_more_link
          annotations << {
            type: 'net.app.core.crosspost',
            value: {
              canonical_url: self.read_more_link
            }
          }
        end

        annotations
      end

      def message
        {
          annotations: self.annotations,
          text: self.text,
          machine_only: (not self.text)
        }
      end

      def send
        Message.new ADN::API::Message.create(self.channel_id, self.message)["data"]
      end
    end
  end
end
