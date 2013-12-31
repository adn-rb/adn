# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::Message do
  subject { ADN::API::Message }

  let(:base_path) { '/stream/0/channels' }

  let(:error_id) do
    '6f5137beac6c4b9ea8dbec8e50aa9f38$32a85f1c22e98de98ea2ddabaf76c5ae'
  end

  let(:error_message) do
    'Call requires authentication: This view requires' +
    ' authentication and no token was provided.'
  end

  let(:error_response) {
    OpenStruct.new(:body =>
      %Q{ { "meta" : {
            "code" : 401,
            "error_id" : "#{error_id}",
            "error_message" : "#{error_message}"
      }}
    })
  }

  describe "new" do
    it "messages the passed in params to the API" do
      args(:post) {
        path, params = subject.create(1, { foo: 'bar' })

        path.must_equal base_path + '/1/messages'
        params.must_equal foo: 'bar'
      }
    end

    it 'retrieves error message correctly' do
      ADN::HTTP.stub(:request, error_response) do
        error_call = lambda {subject.create(1, { foo: 'bar' })}
        error_call.must_raise ADN::API::Error

        error = error_call.call rescue $!
        error.message.must_equal error_message
      end
    end
  end

  describe "retrieve" do
    it "retrieves the message" do
      arg(:get) {
        subject.retrieve(8, 22).must_equal base_path + "/8/messages/22"
      }
    end
  end

  describe "by_id" do
    it "is just an alias for retrieve" do
      subject.stub(:retrieve, 'bar') do
        subject.by_id(4, 456).must_equal 'bar'
      end
    end
  end

  describe "delete" do
    it "deletes the message" do
      arg(:delete) {
        subject.delete(5, 77).must_equal base_path + "/5/messages/77"
      }
    end
  end
end
