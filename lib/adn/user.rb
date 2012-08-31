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
      if user.is_a? Hash
        user.each do |k, v|
          self.instance_variable_set "@#{k}", v
        end
        @user_id = self.id
      else
        @user_id = user
        details = self.details
        if details.has_key? "data"
          details["data"].each do |k, v|
            self.instance_variable_set "@#{k}", v
          end
        end
      end
    end

    def details
      if self.id
        # TODO: Replace with call to each_with_object
        #       after the spec has been written
        h = {}
        self.instance_variables.each { |iv|
          h[iv.to_s.gsub(/[^a-zA-Z0-9_]/, '')] = self.instance_variable_get(iv)
        }
        h
      else
        ADN::API::User.retrieve(@user_id)
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
      User.new(result["data"]) unless ADN.has_error?(result)
    end

    def unfollow(user)
      user_id = get_user(user)
      result = ADN.delete("/stream/0/users/#{user_id}/follow")
      User.new(result["data"]) unless ADN.has_error?(result)
    end

    def followers
      result = ADN::API::User.followers(@user_id)
      result["data"].collect { |u| User.new(u) } unless ADN.has_error?(result)
    end

    def following
      result = ADN::API::User.following(@user_id)
      result["data"].collect { |u| User.new(u) } unless ADN.has_error?(result)
    end


    # Mute

    def mute(user)
      user_id = get_user(user)
      result = ADN.post("/stream/0/users/#{user_id}/mute")
      User.new(result["data"]) unless ADN.has_error?(result)
    end

    def unmute(user)
      user_id = get_user(user)
      result = ADN.delete("/stream/0/users/#{user_id}/mute")
      User.new(result["data"]) unless ADN.has_error?(result)
    end

    def mute_list
      result = ADN.get("/stream/0/users/me/muted")
      result["data"].collect { |u| User.new(u) } unless ADN.has_error?(result)
    end


    # Posts

    def posts(params = nil)
      result = ADN::API::Post.by_user(@user_id, params)
      result["data"].collect { |p| Post.new(p) } unless ADN.has_error?(result)
    end

    def stream(params = nil)
      result = ADN::API::Post.stream(params)
      result["data"].collect { |p| Post.new(p) } unless ADN.has_error?(result)
    end

    def mentions(params = nil)
      result = ADN::API::Post.mentioning_user(@user_id, params)
      result["data"].collect { |p| Post.new(p) } unless ADN.has_error?(result)
    end

    # Errors

    def has_error?
      self.id.nil?
    end
  end
end
