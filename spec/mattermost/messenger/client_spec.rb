# frozen_string_literal: true

RSpec.describe Mattermost::Messenger::Client do
  context "Client Initialization" do
    it "can create an instance of mattermost messenger client" do
      client = Mattermost::Messenger::Client.new
      expect(client).to be_a Mattermost::Messenger::Client
    end

    it "can create a client with proper options" do
      options = build(:options, webhook_url: "https://5xruby.tw")
      client = Mattermost::Messenger::Client.new(options: options)

      expect(client.webhook_url).to eq "https://5xruby.tw"
    end

    it "can create a client with ENV['MATTERMOST_WEBHOOK_URL'] if no webhook_url provided" do
      options = build(:options, :without_webhook_url)
      client = Mattermost::Messenger::Client.new(options: options)

      expect(client.webhook_url).to eq ENV.fetch("MATTERMOST_WEBHOOK_URL", nil)
    end
  end

  context "Sending Message" do
    context "Success" do
      it "can send message" do
        options = build(:options, :with_env)
        client = Mattermost::Messenger::Client.new(options: options)

        VCR.use_cassette(:mattermost_send_message1) do
          response = client.send_messages!
          expect(response.code).to eq "200"
        end
      end

      it "can also send message with parameters" do
        options = build(:options, :with_env)
        client = Mattermost::Messenger::Client.new(options: options)

        VCR.use_cassette(:mattermost_send_message2) do
          messages = [ { title: "hello", content: "world" } ]
          title = {text: "Test Title", link: "https://5xruby.tw"}
          response = client.send_messages!(title: title, messages: messages, type: :alert)
          expect(response.code).to eq "200"
        end
      end
    end

    context "Fail" do
    end
  end

  # Specs:
  # send message fail if webhook_url is not available
  # can not send message if either message nor webhook_url is absensed
  # can send a success message(color: Green, default)
  # can send an alert message(color: Red)
end
