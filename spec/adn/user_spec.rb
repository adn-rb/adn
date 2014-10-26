# encoding: UTF-8

require_relative '../spec_helper'

describe ADN::User do
  subject { ADN::User }

  let(:empty_user) { subject.new({})        }
  let(:user)       { subject.new(user_data) }
  let(:user_response)  { fixture('user.json')   }
  let(:user_data) { user_response["data"] }

  describe "me" do
    it "retrieves the user based on the current token" do
      ADN::API::Token.stub(:current, { "user" => user_data }) do
        u = subject.me
        u.user_id.must_equal "4821"
        u.username.must_equal "peterhellberg"
      end
    end
  end

  describe "find" do
    it "retrieves the user data from the API and returns a User object" do
      ADN::API::User.stub(:retrieve, user_response) do
        u = subject.find("4821")
        u.name.must_equal "Peter Hellberg"
        u.user_id.must_equal "4821"
      end
    end
  end

  describe "initialize" do
    it "populates the accessors based on the raw user data passed in" do
      u = subject.new(user_data)
      u.name.must_equal "Peter Hellberg"
      u.user_id.must_equal "4821"
    end
  end

  describe "created_at" do
    it "it returns the date and time the user was created" do
      user.created_at.to_s.must_equal '2012-08-17T00:38:18+00:00'
    end
  end

  describe "follow" do
    it "" do
    end
  end

  describe "unfollow" do
    it "" do
    end
  end

  describe "followers" do
    it "" do
    end
  end

  describe "following" do
    it "" do
    end
  end

  describe "mute" do
    it "" do
    end
  end

  describe "unmute" do
    it "" do
    end
  end

  describe "mute_list" do
    it "" do
    end
  end

  describe "posts" do
    it "" do
    end
  end

  describe "stream" do
    it "" do
    end
  end

  describe "mentions" do
    it "" do
    end
  end

  describe "set_values" do
    it "only sets valid attributes" do
      u = subject.new({})
      u.set_values({ foo: 'bar', name: 'Molly' })
      u.name.must_equal 'Molly'
      -> { u.foo }.must_raise NoMethodError
    end
  end

  describe "valid_user?" do
    it "returns false if no id" do
      empty_user.valid_user?.must_equal false
    end

    it "returns true if the user has an id" do
      user.valid_user?.must_equal true
    end
  end
end
