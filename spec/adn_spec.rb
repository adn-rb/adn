# encoding: UTF-8

require_relative 'spec_helper'

describe ADN do
  subject { ADN }

  let(:example_token) {
    'f1d2d2f924e986ac86fdf7b36c94bcdf32beec15'
  }

  it "can set and get a token" do
    subject.token.must_equal nil
    subject.token = example_token
    subject.token.must_equal example_token
  end

  it "has a constant containing the hostname of the api" do
    ADN::API_HOST.must_equal 'alpha-api.app.net'
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
