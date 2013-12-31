# encoding: UTF-8
require 'mime/types'
require 'net/http/post/multipart'

module ADN
  module API
    module File
      def self.create(filename, params)
        string_io = StringIO.new(params.to_json)

        content   = UploadIO.new(filename, MIME::Types.type_for(filename)[0])
        metadata  = UploadIO.new(string_io, "application/json", "data")

        http_params = {
          "content" => content,
          # make a fake file so we can still pass json
          "metadata" => metadata
        }

        ADN::API.post_multipart("#{ADN::API_ENDPOINT_FILES}", http_params)
      end

      def self.retrieve(file_id)
        ADN::API.get("#{ADN::API_ENDPOINT_FILES}/#{file_id}")
      end

      def self.by_id(file_id)
        self.retrieve(file_id)
      end

      def self.delete(file_id)
        ADN::API.delete("#{ADN::API_ENDPOINT_FILES}/#{file_id}")
      end
    end
  end
end
