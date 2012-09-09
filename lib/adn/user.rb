# encoding: UTF-8

module ADN
  class User
    attr_accessor :user_id
    attr_accessor :avatar_image, :counts, :cover_image,
                  :created_at, :description, :follows_you,
                  :id, :is_follower, :is_following, :is_muted,
                  :locale, :name, :timezone, :type, :username,
                  :you_follow, :you_muted

    def initialize(user)
      if user.respond_to?(:each_pair)
        set_values(user)
        self.user_id = id
      else
        self.user_id = user
        user_details = details
        if details.has_key? "data"
          set_values(user_details["data"])
        end
      end
    end

    def details
      if id
        Hash[self.instance_variables.map { |i| [i.to_s.slice(1..-1), self.instance_variable_get(i)]}]
      else
        ADN::API::User.retrieve(user_id)
      end
    end

    def created_at
      DateTime.parse(@created_at)
    end

    # Followers/Users

    def get_user(user)
      user.is_a?(ADN::User) ? user.id : user
    end

    def follow(user)
      user_id = get_user(user)
      result = ADN.post("/stream/0/users/#{user_id}/follow")
      ADN.create_instance(result["data"], User) unless result.has_error?
    end

    def unfollow(user)
      user_id = get_user(user)
      result = ADN.delete("/stream/0/users/#{user_id}/follow")
      ADN.create_instance(result["data"], User) unless result.has_error?
    end

    def followers
      result = ADN::API::User.followers(user_id)
      ADN.create_collection(result["data"], User) unless result.has_error?
    end

    def following
      result = ADN::API::User.following(user_id)
      ADN.create_collection(result["data"], User) unless result.has_error?
    end

    # Mute

    def mute(user)
      user_id = get_user(user)
      result = ADN.post("#{ADN::API_ENDPOINT_USERS}/#{user_id}/mute")
      ADN.create_instance(result["data"], User) unless result.has_error?
    end

    def unmute(user)
      user_id = get_user(user)
      result = ADN.delete("#{ADN::API_ENDPOINT_USERS}/#{user_id}/mute")
      ADN.create_instance(result["data"], User) unless result.has_error?
    end

    def mute_list
      result = ADN.get("#{ADN::API_ENDPOINT_USERS}/me/muted")
      ADN.create_collection(result["data"], User) unless result.has_error?
    end

    # Posts

    def posts(params = nil)
      result = ADN::API::Post.by_user(user_id, params)
      ADN.create_collection(result["data"], Post) unless result.has_error?
    end

    def stream(params = nil)
      result = ADN::API::Post.stream(params)
      ADN.create_collection(result["data"], Post) unless result.has_error?
    end

    def mentions(params = nil)
      result = ADN::API::Post.mentioning_user(user_id, params)
      ADN.create_collection(result["data"], Post) unless result.has_error?
    end

    def set_values(values)
      values.each_pair { |k, v| send("#{k}=", v) if respond_to?("#{k}=") }
    end

    def has_error?
      self.id.nil?
    end
  end
end
