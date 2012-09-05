# encoding: UTF-8

module ADN
  module API
    module Post
      def self.create(params)
        ADN::API.post("#{ADN::API_ENDPOINT_POSTS}", params)
      end

      def self.retrieve(post_id)
        ADN::API.get("#{ADN::API_ENDPOINT_POSTS}/#{post_id}")
      end

      def self.by_id(post_id)
        self.retrieve(post_id)
      end

      def self.delete(post_id)
        ADN::API.delete("#{ADN::API_ENDPOINT_POSTS}/#{post_id}")
      end

      def self.replies(post_id, params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_POSTS}/#{post_id}/replies", params)
      end

      def self.by_user(user_id, params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_USERS}/#{user_id}/posts", params)
      end

      def self.mentioning_user(user_id, params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_USERS}/#{user_id}/mentions", params)
      end

      def self.stream(params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_POSTS}/stream", params)
      end

      def self.global_stream(params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_POSTS}/stream/global", params)
      end

      def self.by_hashtag(hashtag, params = nil)
        ADN::API.get("#{ADN::API_ENDPOINT_POSTS}/tag/#{hashtag}", params)
      end
    end
  end
end