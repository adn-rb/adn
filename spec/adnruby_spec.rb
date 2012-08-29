require_relative 'spec_helper'

describe "ADNRuby" do
  # TODO: Move into the ADN module, and rename using snake case
  it "currently has a constant containing the hostname of the api" do
    APIHOST.must_equal 'alpha-api.app.net'
  end

  # TODO: Move into the ADN module, and rename using snake case
  #       Should probably be refactored to a separate class
  it "currently has a constant containing a http client" do
    ADNHTTP.tap { |http|
      http.address.must_equal "alpha-api.app.net"
      http.port.must_equal 443
      http.use_ssl?.must_equal true
    }
  end

  # TODO: Put the error handling somewhere else.
  it "currently monkeypatches Hash" do
    { 'error' => 123 }.has_error?.must_equal true
    { 'other' => 000 }.has_error?.must_equal false
  end
end
