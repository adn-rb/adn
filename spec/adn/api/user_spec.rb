# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::User do
  subject { ADN::API::User }

  let(:base_path) { '/stream/0/users/' }

  describe "retrieve" do
    it "retrieves the user" do
      arg(:get) { subject.retrieve(55).must_equal base_path + "55" }
    end
  end

  describe "following" do
    it "retrieves the following list" do
      arg(:get) { subject.following(44).must_equal base_path + "44/following" }
    end
  end

  describe "followers" do
    it "retrieves the followers list" do
      arg(:get) { subject.following(66).must_equal base_path + "66/following" }
    end
  end
end
