# frozen_string_literal: true

require_relative "messenger/all"

module Mattermost
  module Messenger
    class NoWebhookUrlError < StandardError; end
  end
end
