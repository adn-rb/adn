# encoding: UTF-8

require_relative '../spec_helper'

def d(data)
  { 'data' => data }
end

describe ADN::File do
  subject { ADN::File }

  let(:file)       { subject.new(file_data) }
  let(:example_user) { { username: 'peterhellberg' } }
  let(:file_data) {{
    created_at: '1999-12-31T23:59:59Z',
    id: 10001,
    user: example_user,
    file_token: "abc123",
    sha1: "d5e7c7a123108739a28d721eb34133600a70a7fa",
    name: "foo.txt",
    source: { link: "https://alpha.app.net", name: "Alpha" },
    url: "https://adn-uf-01.s3.amazonaws.com/adn-uf-01/really_long_filepath",
    kind: "other",
    total_size: 2248,
    url_expires: "2013-12-14T02:00:00Z",
    size: 2248,
    type: "net.app.testing",
    public: false,
    mime_type: "text/plain",
    complete: true
  }}

  describe "upload_file" do
    it "creates a message via the API" do
      ADN::API::File.stub(:create, ADN::API::Response.new(d(file_data))) do
        m = subject.upload_file("foo.txt", {type: "net.app.testing"})
        m.type.must_equal 'net.app.testing'
        m.name.must_equal 'foo.txt'
      end
    end
  end

  describe "initialize" do
    it "populates the accessors using the passed in hash" do
      m = subject.new id: 123
      m.id.must_equal 123
    end

    it "populates the accessors based on the passed in id" do
      ADN::API::File.stub(:by_id, ->(i){ d({ "total_size" => 1234}) }) do
        f = subject.new 123
        f.total_size.must_equal 1234
      end
    end
  end

  describe "details" do
    it "returns the details for the file" do
      file.details.keys.must_equal [
        "created_at", "id", "user", "file_token", "sha1", "name", "source", "url", "kind", "total_size",
        "url_expires", "size", "type", "public", "mime_type", "complete"
      ]
    end
  end

  describe "created_at" do
    it "returns the date and time the message was created" do
      file.created_at.to_s.must_equal '1999-12-31T23:59:59+00:00'
    end
  end

  describe "user" do
    it "returns the user" do
      file.user.username.must_equal 'peterhellberg'
    end
  end

  describe "delete" do
    it "deletes the file via the API and returns the file" do
      delete_stub = ->(id){
        ADN::API::Response.new("data" => { "id" => id })
      }

      ADN::API::File.stub(:delete, delete_stub) do
        file.delete.id.must_equal 10001
      end
    end
  end
end
