# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::File do
  subject { ADN::API::File }

  let(:base_path) { '/stream/0/files' }

  let(:error_id) do
    '6f5137beac6c4b9ea8dbec8e50aa9f38$32a85f1c22e98de98ea2ddabaf76c5ae'
  end

  let(:error_message) do
    'Call requires authentication: This view requires' +
    ' authentication and no token was provided.'
  end

  let(:error_response) do
    OpenStruct.new(:body => %Q{ {
      "meta" : {
        "code" : 401,
        "error_id" : "#{error_id}",
        "error_message" : "#{error_message}"
      }}
    })
  end

  describe "new" do
    it "passes the file content in params to the API" do
      args(:post_multipart) {
        path, params = subject.create(__FILE__, { type: 'foo' })

        path.must_equal base_path
        params["content"].local_path.must_equal __FILE__
        params["content"].content_type.must_equal "application/x-ruby"
        params["metadata"].content_type.must_equal "application/json"

        JSON.parse(params["metadata"].read).must_equal({"type" => 'foo'})
      }
    end

    it 'retrieves error message correctly' do
      ADN::HTTP.stub(:request, error_response) do
        error_call = lambda {subject.create(__FILE__, { foo: 'bar' })}
        error_call.must_raise ADN::API::Error

        error = error_call.call rescue $!
        error.message.must_equal error_message
      end
    end
  end

  describe "retrieve" do
    it "retrieves the file" do
      arg(:get) { subject.retrieve(8).must_equal base_path + "/8" }
    end
  end

  describe "by_id" do
    it "is just an alias for retrieve" do
      subject.stub(:retrieve, 'bar') do
        subject.by_id(4).must_equal 'bar'
      end
    end
  end

  describe "delete" do
    it "deletes the file" do
      arg(:delete) { subject.delete(5).must_equal base_path + "/5" }
    end
  end
end
