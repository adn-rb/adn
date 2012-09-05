# encoding: UTF-8

require_relative 'spec_helper'

describe ADN do
  subject { ADN }

  let(:example_token) {
    'f1d2d2f924e986ac86fdf7b36c94bcdf32beec15'
  }
  
  it "currently checks returned a Hash for errors" do
    subject.has_error?({ 'error' => 123 }).must_equal true
    subject.has_error?({ 'other' => 000 }).must_equal false
  end

  it "can set and get a token" do
    subject.token.must_equal nil
    subject.token = example_token
    subject.token.must_equal example_token
  end

  it "has a constant containing the hostname of the api" do
    ADN::API_HOST.must_equal 'alpha-api.app.net'
  end

  it "has constants containing the API endpoints for posts and users" do
    ADN::API_ENDPOINT_POSTS.must_equal '/stream/0/posts'
    ADN::API_ENDPOINT_USERS.must_equal '/stream/0/users'
  end
  
  it "has constants containing the API endpoints for tokens" do
    ADN::API_ENDPOINT_TOKEN.must_equal '/stream/0/token'
  end

  # TODO: Move into the ADN module, and rename using snake case
  #       Should probably be refactored to a separate class
  it "currently has a constant containing a http client" do
    ADN::HTTP.tap { |http|
      http.address.must_equal "alpha-api.app.net"
      http.port.must_equal 443
      http.use_ssl?.must_equal true
    }
  end
end
