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
        @webhook_url = @options[:webhook_url]
      end
    end
  end
end
