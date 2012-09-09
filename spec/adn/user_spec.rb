# encoding: UTF-8

require_relative '../spec_helper'

describe ADN::User do
  subject { ADN::User }

  let(:empty_user) { subject.new({}) }
  let(:user) { subject.new(user_data) }
  let(:user_data) { fixture('user.json') }

  describe "me" do
    it "retrieves the user based on the current token" do
      ADN::API::Token.stub(:current, { "user" => user_data }) do
        u = subject.me
        u.user_id.must_equal "4821"
        u.username.must_equal "peterhellberg"
      end
    end
  end

  describe "initialize" do
    it "populates the accessors based on the raw user data passed in" do
      u = subject.new(user_data)
      u.user_id.must_equal "4821"
    end

    # TODO: Remove this behavior, wrong level of abstraction
    it "populates the accessors based on the user id passed in" do
      ADN::API::User.stub(:retrieve, { "data" => user_data }) do
        u = subject.new(4821)
        u.name.must_equal "Peter Hellberg"
        u.user_id.must_equal "4821"
      end
    end
  end

  describe "details" do
    it "spec_name" do
    end
  end

  describe "created_at" do
    it "it returns the date and time the user was created" do
      user.created_at.to_s.must_equal '2012-08-17T00:38:18+00:00'
    end
  end

  # TODO: Change the name to describe what
  #       it actually returns (user_id) or
  #       remove it completely
  describe "get_user" do
    it "returns a user id for some reason" do
      empty_user.get_user(user).must_equal "4821"
      empty_user.get_user(123).must_equal 123
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

  describe "has_error?" do
    it "returns true if no id" do
      empty_user.has_error?.must_equal true
    end

    it "returns false if the user has an id" do
      user.has_error?.must_equal false
    end
  end
end
