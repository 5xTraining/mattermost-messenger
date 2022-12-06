# frozen_string_literal: true

RSpec.describe Mattermost::Messenger do
  it "has a version number" do
    expect(Mattermost::Messenger::VERSION).not_to be nil
  end

  it "does something useful" do
    expect(1).to eq(1)
  end
end
