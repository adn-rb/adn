# encoding: UTF-8
require 'mime/types'
require 'net/http/post/multipart'

module ADN
  module API
    module File
      def self.create(filename, params)
        http_params = {
          "content" => UploadIO.new(filename, MIME::Types.type_for(filename)[0]),
          # make a fake file so we can still pass json
          "metadata" => UploadIO.new(StringIO.new(params.to_json), "application/json", "data"),
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
