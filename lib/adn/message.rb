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
      result = ADN::API::Message.create(params)
      Message.new(result["data"])
    end

    def self.by_id(id)
      result = ADN::API::Message.by_id(id)
      Message.new(result["data"])
    end

    def initialize(raw_message)
      if raw_message.respond_to?(:each_pair)
        set_values(raw_message)
        message_id = id
      else
        message_id = raw_message
        message_details = details
        if message_details.has_key? "data"
          set_values(message_details["data"])
        end
      end
    end

    def details
      if id
        value = self.instance_variables.map do |i|
          [i.to_s.slice(1..-1), self.instance_variable_get(i)]
        end
        Hash[value]
      else
        ADN::API::Message.by_id(post_id)
      end
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def user
      ADN::User.new(@user)
    end

    def reply_to_message
      result = ADN::API::Message.by_id(reply_to)
      ADN.create_instance(result["data"], Message)
    end

    def delete
      result = ADN::API::Message.delete(id)
      ADN.create_instance(result["data"], Message)
    end

    def set_values(values)
      values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
end
