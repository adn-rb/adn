# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::Response do
  
  it "currently checks a hash-like response for errors" do
    ADN::API::Response["error", "123"].has_error?.must_equal true
    ADN::API::Response["valid", "123"].has_error?.must_equal false
  end
end