# encoding: UTF-8

require_relative 'spec_helper'

describe "ADNRuby" do
  # TODO: Put the error handling somewhere else.
  it "currently monkeypatches Hash" do
    { 'error' => 123 }.has_error?.must_equal true
    { 'other' => 000 }.has_error?.must_equal false
  end
end
