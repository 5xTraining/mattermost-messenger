# frozen_string_literal: true

module Mattermost
  module Messenger
    class Client
      attr_reader :webhook_url

      def initialize(options: {})
        @options = options
        parse_options
      end

      private

      def parse_options
        p ENV.fetch("MATTERMOST_WEBHOOK_URL", nil)
        @webhook_url = @options[:webhook_url] || ENV.fetch("MATTERMOST_WEBHOOK_URL", nil)
      end
    end
  end
end
