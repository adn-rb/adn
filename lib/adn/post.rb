# encoding: UTF-8

module ADN
  class Post
    attr_accessor :post_id, :created_at, :entities,
                  :html, :id, :num_replies, :reply_to,
                  :source, :text, :thread_id, :user

    def self.send_post(params)
      result = ADN::API::Post.create(params)
      Post.new(result["data"]) unless ADN.has_error?(result)
    end

    def initialize(raw_post)
      if raw_post.respond_to?(:each_pair)
        set_values(raw_post)
        post_id = id
      else
        post_id = raw_post
        post_details = details
        if post_details.has_key? "data"
          set_values(post_details["data"])
        end
      end
    end

    def details
      if id
        Hash[self.instance_variables.map { |i| [i.to_s.slice(1..-1), self.instance_variable_get(i)]}]
      else
        ADN::API::Post.by_id(post_id)
      end
    end

    def created_at
      DateTime.parse(@created_at)
    end

    def user
      ADN::User.new(@user)
    end

    def reply_to_post
      result = ADN::API::Post.by_id(reply_to)
      ADN.create_collection(result["data"], "single", Post) unless ADN.has_error?(result)
    end

    def replies(params = nil)
      result = ADN::API::Post.replies(id, params)
      ADN.create_collection(result["data"], "collection", Post) unless ADN.has_error?(result)
    end

    def delete
      result = ADN::API::Post.delete(id)
      ADN.create_collection(result["data"], "single", Post) unless ADN.has_error?(result)
    end
    
    def set_values(values)
      values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end
  end
end