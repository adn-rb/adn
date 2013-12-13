# encoding: UTF-8

module ADN
  module Recipes
    class BroadcastMessageBuilder
      attr_accessor(
        :headline, :text, :read_more_link, :channel_id, :parse_links, :parse_markdown_links, :photo, :attachment
      )

      def initialize(params = {})
        if params.respond_to? :each_pair
          params.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
        end
        yield self if block_given?
      end

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
          machine_only: (not self.text),
          entities: {
            parse_links: (self.parse_links or self.parse_markdown_links),
            parse_markdown_links: !!self.parse_markdown_links
          }
        }
      end

      def send
        Message.new ADN::API::Message.create(self.channel_id, self.message)["data"]
      end
    end
  end
end
