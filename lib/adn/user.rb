# encoding: UTF-8

module ADN
  class User
    attr_accessor(
      :id, :user_id, :username, :name, :description,
      :timezone, :locale, :avatar_image,
      :cover_image, :type, :counts, :app_data,
      :follows_you, :you_follow, :you_muted
    )

    attr_writer :created_at

    def self.me
      new ADN::API::Token.current["user"]
    end

    def self.find(user_id)
      new ADN::API::User.retrieve(user_id)
    end

    def initialize(user_data = {})
      set_values(user_data)
    end

    def created_at
      DateTime.parse(@created_at)
    end

    # Followers/Users

    def follow(user)
      result = ADN.post("#{ADN::API_ENDPOINT_USERS}/#{user.user_id}/follow")
      ADN.create_instance(result["data"], User)
    end

    def unfollow(user)
      if user.valid_user?
        result = ADN.delete("#{ADN::API_ENDPOINT_USERS}/#{user.user_id}/follow")
        ADN.create_instance(result["data"], User)
      end
    end

    def followers
      result = ADN::API::User.followers(user_id)
      ADN.create_collection(result["data"], User)
    end

    def following
      result = ADN::API::User.following(user_id)
      ADN.create_collection(result["data"], User)
    end

    # Mute

    def mute(user)
      if user.valid_user?
        result = ADN.post("#{ADN::API_ENDPOINT_USERS}/#{user.user_id}/mute")
        ADN.create_instance(result["data"], User)
      end
    end

    def unmute(user)
      if user.valid_user?
        result = ADN.delete("#{ADN::API_ENDPOINT_USERS}/#{user.user_id}/mute")
        ADN.create_instance(result["data"], User)
      end
    end

    def mute_list
      result = ADN.get("#{ADN::API_ENDPOINT_USERS}/me/muted")
      ADN.create_collection(result["data"], User)
    end

    # Posts

    def posts(params = nil)
      result = ADN::API::Post.by_user(user_id, params)
      ADN.create_collection(result["data"], Post)
    end

    def stream(params = nil)
      result = ADN::API::Post.stream(params)
      ADN.create_collection(result["data"], Post)
    end

    def mentions(params = nil)
      result = ADN::API::Post.mentioning_user(user_id, params)
      ADN.create_collection(result["data"], Post)
    end

    def valid_user?
      !!user_id.match(/^\d+$/)
    end

    def set_values(values)
      if values.respond_to? :each_pair
        values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
        self.user_id = id.to_s
      end
    end
  end
end
