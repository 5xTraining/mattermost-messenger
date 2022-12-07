# frozen_string_literal: true

RSpec.describe Mattermost::Messenger::Client do
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

  # Specs:
  # can send message
  # can not send message if either message nor webhook_url is absensed
  # can send an alert message(color: #ff0000)
  # can send a success message(color: #0000ff)
end
