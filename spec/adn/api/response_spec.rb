# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::Response do

  subject { ADN::API::Response }

  it "currently checks a hash-like response for errors" do
    subject.new("meta" => {"code" => 400}).has_error?.must_equal true
    subject.new("meta" => {"code" => 200}).has_error?.must_equal false
  end
end
