# encoding: UTF-8

module ADN
  module Recipes
    def self.send_broadcast(params)
      channel_id = params.delete('channel_id')
      broadcast = params.delete('broadcast')
      text = params.delete('text')
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

      result = ADN::API::Message.create(channel_id, message)
      Message.new(result["data"])
    end
  end
end
