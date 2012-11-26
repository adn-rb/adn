# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::API::Post do
  subject { ADN::API::Post }

  let(:base_path) { '/stream/0/posts' }
  let(:error_message) {'Call requires authentication: This view requires authentication and no token was provided.'}
  let(:error_response) { OpenStruct.new(:body => %Q{ { "meta" : {
                            "code" : 401,
                            "error_id" : "6f5137beac6c4b9ea8dbec8e50aa9f38$32a85f1c22e98de98ea2ddabaf76c5ae",
                            "error_message" : "#{error_message}"
                            }} }) }

  describe "new" do
    it "posts the passed in params to the API" do
      args(:post) {
        path, params = subject.create({ foo: 'bar' })

        path.must_equal base_path
        params.must_equal foo: 'bar'
      }
    end

    it 'retrieves error message correctly' do
      ADN::HTTP.stub(:request, error_response) do
        error_call = lambda {subject.create({ foo: 'bar' })}
        error_call.must_raise ADN::API::Error

        error = error_call.call rescue $!
        error.message.must_equal error_message
      end
    end

  end

  describe "retrieve" do
    it "retrieves the post" do
      arg(:get) { subject.retrieve(22).must_equal base_path + "/22" }
    end
  end

  describe "by_id" do
    it "is just an alias for retrieve" do
      subject.stub(:retrieve, 'bar') do
        subject.by_id(456).must_equal 'bar'
      end
    end
  end

  describe "delete" do
    it "deletes the post" do
      arg(:delete) { subject.delete(77).must_equal base_path + "/77" }
    end
  end

  describe "replies" do
    it "returns replies by post id" do
      args(:get) {
        path, params = subject.replies(33, 'foo')

        path.must_equal base_path + "/33/replies"
        params.must_equal 'foo'
      }
    end
  end

  describe "by_user" do
    it "returns posts by user" do
      args(:get) {
        path, params = subject.by_user(33, 'bar')

        path.must_equal "/stream/0/users/33/posts"
        params.must_equal 'bar'
      }
    end
  end

  describe "mentioning_user" do
    it "returns posts mentioning user" do
      args(:get) {
        path, params = subject.mentioning_user(22, 'baz')

        path.must_equal "/stream/0/users/22/mentions"
        params.must_equal 'baz'
      }
    end
  end

  describe "stream" do
    it "retrieves the stream" do
      args(:get) {
        subject.stream('foo').must_equal [base_path + "/stream", 'foo']
      }
    end
  end

  describe "global_stream" do
    it "retrieves the global stream" do
      args(:get) {
        path, params = subject.global_stream('bar')

        path.must_equal base_path + "/stream/global"
        params.must_equal 'bar'
      }
    end
  end

  describe "unified_stream" do
    it "retrieves the unified stream" do
      args(:get) {
        path, params = subject.unified_stream('baz')

        path.must_equal base_path + "/stream/unified"
        params.must_equal 'baz'
      }
    end
  end

  describe "by_hashtag" do
    it "retrieves posts by hashtag" do
      args(:get) {
        path, params = subject.by_hashtag('ruby', 'foo')

        path.must_equal base_path + "/tag/ruby"
        params.must_equal 'foo'
      }
    end
  end
end
