# encoding: UTF-8

module ADN
  module API
    module Post
      def self.new(params)
        ADN.post("/stream/0/posts", params)
      end

      def self.retrieve(post_id)
        ADN.get("/stream/0/posts/#{post_id}")
      end

      def self.by_id(post_id)
        self.retrieve(post_id)
      end

      def self.delete(post_id)
        ADN.delete("/stream/0/posts/#{post_id}")
      end

      def self.replies(post_id, params = nil)
        ADN.get("/stream/0/posts/#{post_id}/replies", params)
      end

      def self.by_user(user_id, params = nil)
        ADN.get("/stream/0/users/#{user_id}/posts", params)
      end

      def self.mentioning_user(user_id, params = nil)
        ADN.get("/stream/0/users/#{user_id}/mentions", params)
      end

      def self.stream(params = nil)
        ADN.get("/stream/0/posts/stream", params)
      end

      def self.global_stream(params = nil)
        ADN.get("/stream/0/posts/stream/global", params)
      end

      def self.by_hashtag(hashtag, params = nil)
        ADN.get("/stream/0/posts/tag/#{hashtag}", params)
      end
    end
  end
end
