# encoding: UTF-8

module ADN
  module Recipes
    def self.send_broadcast(params)
      channel_id     = params.delete('channel_id')
      broadcast      = params.delete('broadcast')
      text           = params.delete('text')
      read_more_link = params.delete('read_more_link')

      message = {
        annotations: [
          {
            type: 'net.app.core.broadcast.message.metadata',
            value: {
              subject: broadcast
            }
          }
        ],
        text: text,
        machine_only: (not text)
      }

      if read_more_link
        message[:annotations] << {
          type: 'net.app.core.crosspost',
          value: {
            canonical_url: read_more_link
          }
        }
      end

      build_message(channel_id, message)
    end

    def self.build_message(channel_id, message)
      Message.new ADN::API::Message.create(channel_id, message)["data"]
    end
  end
end
