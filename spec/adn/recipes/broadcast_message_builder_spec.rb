# encoding: UTF-8

require_relative '../../spec_helper'

describe ADN::Recipes::BroadcastMessageBuilder do
  subject { ADN::Recipes::BroadcastMessageBuilder.new }

  describe "annotations" do
    describe "with a read more link" do
      it "generates a crosspost annotation" do
        subject.headline = "foo"
        subject.read_more_link = "http://app.net"
        subject.annotations.must_equal([
          {
            type: "net.app.core.broadcast.message.metadata",
            value: { subject: "foo" }
          },
          {
            type: "net.app.core.crosspost",
            value: { canonical_url: "http://app.net" }
          }
        ])
      end
    end

    describe "with only a headline" do
      it "generates a message metadata annotation" do
        subject.headline = "foo"
        subject.annotations.must_equal([
          {
            type: "net.app.core.broadcast.message.metadata",
            value: { subject: "foo" }
          },
        ])
      end
    end

    describe "with a photo" do
      it "generates an oembed annotation" do
        api_response = ADN::API::Response.new({
          "data" => {
            id: "1",
            file_token: "1234"
          }
        })

        ADN::API::File.stub(:create, api_response) do
          subject.headline = "foo"
          subject.photo = "foo.jpg"
          subject.annotations.must_equal([
            {
              type: "net.app.core.broadcast.message.metadata",
              value: { subject: "foo" }
            },
            {
              type: "net.app.core.oembed",
              value: { "+net.app.core.file" => {
                file_id: "1",
                file_token: "1234",
                format: "oembed"
              }}
            }
          ])
        end
      end
    end

    describe "with an attachment" do
      it "generates an attachment annotation" do
        api_response = ADN::API::Response.new({
          "data" => {
            id: "1",
            file_token: "1234"
          }
        })

        ADN::API::File.stub(:create, api_response) do
          subject.headline = "foo"
          subject.attachment = "foo.txt"
          subject.annotations.must_equal([
            {
              type: "net.app.core.broadcast.message.metadata",
              value: { subject: "foo" }
            },
            {
              type: "net.app.core.attachments",
              value: { "+net.app.core.file_list" => [
                {
                  file_id: "1",
                  file_token: "1234",
                  format: "metadata"
                }
              ]}
            }
          ])
        end
      end
    end
  end

  describe "message" do
    describe "with text" do
      it "includes the extra text" do
        subject.headline = "foo"
        subject.text = "bar"
        subject.message[:text].must_equal("bar")
        subject.message[:machine_only].must_equal(nil)
      end
    end

    describe "without text" do
      it "generates a machine only message" do
        subject.headline = "foo"
        subject.message[:text].must_be_nil
        subject.message[:machine_only].must_equal(true)
      end

      it "includes the annotations" do
        subject.headline = "bar"
        subject.message[:annotations].must_equal([
          {
            type: "net.app.core.broadcast.message.metadata",
            value: { subject: "bar" }
          },
        ])
      end
    end

    it "allows you to parse links" do
      subject.headline = "foo"
      subject.parse_links = true
      subject.message[:entities].must_equal({
        parse_links: true,
        parse_markdown_links: false
      })
    end

    it "parses links when you ask for parsing markdown links" do
      subject.headline = "foo"
      subject.parse_markdown_links = true
      subject.message[:entities].must_equal({
        parse_links: true,
        parse_markdown_links: true
      })
    end
  end

  describe "send" do
    it "calls the api with the message" do
      headline = "foo"
      channel_id = "123"
      response_body = %Q{{
        "meta": {
          "code": 200
        },
        "data": {
          "annotations": [
            {
              "type": "net.app.core.broadcast.message.metadata",
              "value": {"subject": "#{headline}"}
            }
          ],
          "channel_id": "#{channel_id}"
        }
      }}

      response = OpenStruct.new(:body => response_body)

      ADN::HTTP.stub(:request, response) do
        subject.headline = headline
        subject.channel_id = channel_id

        message = subject.send
        message.channel_id.must_equal channel_id
        message.annotations[0]["value"]["subject"].must_equal headline
      end
    end
  end
end
