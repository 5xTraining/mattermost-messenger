# frozen_string_literal: true

RSpec.describe Mattermost::Messenger::Client do
  it "can create an instance of mattermost messenger client" do
    client = Mattermost::Messenger::Client.new
    expect(client).to be_a Mattermost::Messenger::Client
  end
end
