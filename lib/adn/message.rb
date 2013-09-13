# encoding: UTF-8

module ADN
  class Message
    attr_accessor(
      :id, :message_id, :channel_id, :text,
      :html, :source, :machine_only,
      :reply_to, :thread_id,
      :num_replies, :annotations, :entities,
    )

    attr_writer :user, :created_at

    def self.send_message(params)
      channel_id = params.delete('channel_id')
      result = ADN::API::Message.create(channel_id, params)
      Message.new(result["data"])
    end

    def self.by_id(channel_id, id)
      result = ADN::API::Message.by_id(channel_id, id)
      Message.new(result["data"])
    end

    def initialize(raw_message)
      set_values(raw_message)
      message_id = id

      if raw_message.length == 2 and raw_message.key? :id and raw_message.key? :channel_id
        # If we only have the bare minimum data, assume we want to get values from the server
        message_details = details
        if message_details.has_key? "data"
          set_values(message_details["data"])
        end
      end
    end

    def details
      # if we have a source, then we've loaded stuff from the server
      if source
        value = self.instance_variables.map do |i|
          [i.to_s.slice(1..-1), self.instance_variable_get(i)]
        end
        Hash[value]
      else
        ADN::API::Message.by_id(channel_id, message_id)
      end
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def user
      ADN::User.new(@user)
    end

    def delete
      result = ADN::API::Message.delete(channel_id, id)
      ADN.create_instance(result["data"], Message)
    end

    def set_values(values)
      values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
end
