# encoding: UTF-8

require_relative '../spec_helper'

def d(data)
  { 'data' => data }
end

describe ADN::Message do
  subject { ADN::Message }

  let(:empty_message) do
    subject.new({})
  end

  let(:message_with_id) do
    subject.new({
      channel_id: '456',
      message_id: '123'
    })
  end

  let(:msg) do
    subject.new(message_data)
  end

  let(:example_user) do
    {
      username: 'peterhellberg'
    }
  end

  let(:message_data) {
    {
     created_at: '1999-12-31T23:59:59Z',
     entities: {},
     html: '<b>The sky above the port…</b>',
     id: 10001,
     channel_id: 65432,
     num_replies: 1,
     reply_to: 66,
     source: { link: "https://alpha.app.net", name: "Alpha" },
     text: "The sky above the port…",
     thread_id: "301856",
     user: example_user
    }
  }

  describe "send_message" do
    it "creates a message via the API" do
      api_response = ADN::API::Response.new(d(message_data))

      ADN::API::Message.stub(:create, api_response) do
        m = subject.send_message({})
        m.text.must_equal 'The sky above the port…'
      end
    end
  end

  describe "initialize" do
    it "populates the accessors using the passed in hash" do
      m = subject.new text: 'foo', id: 123, channel_id: 456
      m.text.must_equal 'foo'
    end

    # TODO: Change this behavior (Add a find method instead)
    it "populates the accessors based on the passed in id" do
      by_id = ->(c_id, i){ d({ "text" => 'bar'}) }

      ADN::API::Message.stub(:by_id, by_id) do
        m = subject.new id: 123, channel_id: 456
        m.text.must_equal 'bar'
      end
    end
  end

  describe "details" do
    it "returns the details for the message" do
      msg.details.keys.must_equal [
        "created_at", "entities", "html",
        "id", "channel_id", "num_replies", "reply_to",
        "source", "text", "thread_id", "user"
      ]
    end

    it "returns the message from the api if it has no id" do
      by_id = ->(c_id, i){ d({ "id" => i, "channel_id" => c_id}) }

      ADN::API::Message.stub(:by_id, by_id) do
        message_with_id.details.must_equal({
          "data" => {
            "id" => '123',
            "channel_id" => '456'
          }
        })
       end
    end
  end

  describe "created_at" do
    it "returns the date and time the message was created" do
      msg.created_at.to_s.must_equal '1999-12-31T23:59:59+00:00'
    end
  end

  describe "user" do
    it "returns the user" do
      msg.user.username.must_equal 'peterhellberg'
    end
  end

  describe "delete" do
    it "deletes the message via the API and returns the message" do
      delete_stub = ->(c_id, id){
        ADN::API::Response.new("data" => {
          "channel_id" => c_id,
          "id" => id
        })
      }

      ADN::API::Message.stub(:delete, delete_stub) do
        msg.delete.id.must_equal 10001
      end
    end
  end

  describe "set_values" do
    it "sets values with accessors" do
      m = empty_message

      m.set_values(message_data)

      m.entities.must_equal    message_data[:entities]
      m.html.must_equal        message_data[:html]
      m.id.must_equal          message_data[:id]
      m.num_replies.must_equal message_data[:num_replies]
      m.reply_to.must_equal    message_data[:reply_to]
      m.source.must_equal      message_data[:source]
      m.text.must_equal        message_data[:text]
      m.thread_id.must_equal   message_data[:thread_id]

      m.created_at.must_equal  DateTime.parse(message_data[:created_at])

      m.user.username.must_equal message_data[:user][:username]
    end

    it "does not set arbitrary values" do
      m = subject.new foo: 'bar'
      -> { m.foo }.must_raise NoMethodError
    end
  end
end
