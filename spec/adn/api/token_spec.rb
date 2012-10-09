# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::Token do
  subject { ADN::API::Token }

  describe "current" do
    it "does not return the current token if it has an error" do
      ADN::API.stub(
        :get, ADN::API::Response.new("error" => "error message")) do
        subject.current.must_equal nil
      end
    end

    it "retrieves the current token" do
      ADN::API.stub(
        :get, ADN::API::Response.new("data" => "example_token")) do
        subject.current.must_equal "example_token"
      end
    end
  end
end
