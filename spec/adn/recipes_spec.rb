# encoding: UTF-8

require_relative '../spec_helper'

class Example
  extend ADN::Recipes
end

describe ADN::Recipes do
  subject { ADN::Recipes }

  describe "send_broadcast" do
    describe "with params including a read more link" do
      let(:params) do
        {
          'channel_id'     => 123,
          'broadcast'      => 'foo',
          'text'           => 'bar',
          'read_more_link' => 'baz'
        }
      end

      it "generates a broadcast message" do
        subject.stub(:build_message, ->(*args) { args }) do
          channel_id, message = subject.send_broadcast(params)

          channel_id.must_equal 123

          message.must_equal({
            annotations: [
              {
                type: "net.app.core.broadcast.message.metadata",
                value: { subject: "foo" }
              },
              {
                type: "net.app.core.crosspost",
                value: { canonical_url: "baz" }
              }
            ],
            text: "bar",
            machine_only: false
          })
        end
      end
    end

    describe "with params without a read more link" do
      let(:params) do
        {
          'channel_id' => 456,
          'broadcast'  => 'qux',
          'text'       => 'quux'
        }
      end

      it "generates a broadcast message" do
        subject.stub(:build_message, ->(*args) { args }) do
          channel_id, message = subject.send_broadcast(params)

          channel_id.must_equal 456

          message.must_equal({
            annotations: [
              {
                type: "net.app.core.broadcast.message.metadata",
                value: { subject: "qux" }
              }
            ],
            text: "quux",
            machine_only: false
          })
        end
      end
    end

    describe "with params without text" do
      let(:params) do
        {
          'channel_id' => 789,
          'broadcast'  => 'corge'
        }
      end

      it "generates a broadcast message" do
        subject.stub(:build_message, ->(*args) { args }) do
          channel_id, message = subject.send_broadcast(params)

          message.must_equal({
            annotations: [
              {
                type: "net.app.core.broadcast.message.metadata",
                value: { subject: "corge" }
              }
            ],
            text: nil,
            machine_only: true
          })
        end
      end
    end
  end
end
