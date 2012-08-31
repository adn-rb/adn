# encoding: UTF-8

require_relative 'spec_helper'

describe "ADNRuby" do
  it "currently checks returned a Hash for errors" do
    ADN.has_error?({ 'error' => 123 }).must_equal true
    ADN.has_error?({ 'other' => 000 }).must_equal false
  end
end
