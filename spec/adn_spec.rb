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
end
