# encoding: UTF-8

module ADN
  class File
    attr_accessor(
      :id, :file_token, :sha1, :name, :source, :url, :kind, :total_size,
      :url_expires, :size, :type, :public, :mime_type, :complete
    )

    attr_writer :user, :created_at

    def self.upload_file(params)
      result = ADN::API::File.create(params)
      File.new(result["data"])
    end

    def self.by_id(id)
      result = ADN::API::File.by_id(id)
      File.new(result["data"])
    end

    def initialize(raw_file)
      if raw_file.respond_to?(:each_pair)
        set_values(raw_file)
        file_id = id
      else
        file_id = raw_file
        file_details = details
        if file_details.has_key? "data"
          set_values(file_details["data"])
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
        ADN::API::File.by_id(file_id)
      end
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def user
      ADN::User.new(@user)
    end

    def delete
      result = ADN::API::File.delete(id)
      ADN.create_instance(result["data"], File)
    end

    def set_values(values)
      values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
end
