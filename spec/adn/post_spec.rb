# encoding: UTF-8

require_relative '../spec_helper'

def d(data)
  { 'data' => data }
end

describe ADN::Post do
  subject { ADN::Post }

  let(:empty_post) { subject.new({}) }
  let(:post_with_id) { subject.new({ post_id: 123 }) }
  let(:post) { subject.new(post_data) }

  let(:example_user) { { username: 'peterhellberg' } }
  let(:post_data) {
    {
     created_at: '1999-12-31T23:59:59Z',
     entities: {},
     html: '<b>The sky above the port…</b>',
     id: 10001,
     num_replies: 1,
     reply_to: 66,
     source: { link: "https://alpha.app.net", name: "Alpha" },
     text: "The sky above the port…",
     thread_id: "301856",
     user: example_user
    }
  }

  describe "send_post" do
    it "creates a post via the API" do
      ADN::API::Post.stub(:create, d(post_data)) do
        p = subject.send_post({})
        p.text.must_equal 'The sky above the port…'
      end
    end
  end

  describe "initialize" do
    it "populates the accessors using the passed in hash" do
      p = subject.new text: 'foo', id: 123
      p.text.must_equal 'foo'
    end

    # TODO: Change this behavior (Add a find method instead)
    it "populates the accessors based on the passed in id" do
      ADN::API::Post.stub(:by_id, ->(i){ d({ "text" => 'bar'}) }) do
        p = subject.new 456
        p.text.must_equal 'bar'
      end
    end
  end

  describe "details" do
    it "returns the details for the post" do
      post.details.keys.must_equal [
        "created_at", "entities", "html",
        "id", "num_replies", "reply_to",
        "source", "text", "thread_id", "user"
      ]
    end

    it "returns the post from the api if it has no id" do

       ADN::API::Post.stub(:by_id, ->(i){ d({ "id" => i}) }) do
         post_with_id.details.
           must_equal({ "data" => { "id" => 123 } })
       end
    end
  end

  describe "created_at" do
    it "returns the date and time the post was created" do
      post.created_at.to_s.must_equal '1999-12-31T23:59:59+00:00'
    end
  end

  describe "user" do
    it "returns the user" do
      post.user.username.must_equal 'peterhellberg'
    end
  end

  describe "reply_to_post" do
    it "returns the post that was replied to" do
      ADN::API::Post.stub(:by_id, ->(id){ d({ "id" => id }) }) do
        post.reply_to_post.id.must_equal 66
      end
    end
  end

  describe "replies" do
    it "returns a list of posts" do
      data = { "data" => [{ text: 'foo' }, { text: 'bar'}]}

      ADN::API::Post.stub(:replies, ->(*a){ data }) do
        r = post.replies
        r.size.must_equal 2
        r[0].text.must_equal 'foo'
        r[1].text.must_equal 'bar'
      end
    end
  end

  describe "delete" do
    it "deletes the post via the API and returns a new post" do
      delete_stub = ->(id){ d({ "id" => id*2 }) }

      ADN::API::Post.stub(:delete, delete_stub) do
        post.delete.id.must_equal 20002
      end
    end
  end

  describe "set_values" do
    it "sets values with accessors" do
      p = empty_post

      p.set_values(post_data)

      p.entities.must_equal    post_data[:entities]
      p.html.must_equal        post_data[:html]
      p.id.must_equal          post_data[:id]
      p.num_replies.must_equal post_data[:num_replies]
      p.reply_to.must_equal    post_data[:reply_to]
      p.source.must_equal      post_data[:source]
      p.text.must_equal        post_data[:text]
      p.thread_id.must_equal   post_data[:thread_id]

      p.created_at.must_equal  DateTime.parse(post_data[:created_at])

      p.user.username.must_equal post_data[:user][:username]
    end

    it "does not set arbitrary values" do
      p = subject.new foo: 'bar'
      -> { p.foo }.must_raise NoMethodError
    end
  end
end
