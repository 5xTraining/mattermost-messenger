# frozen_string_literal: true

require "uri"
require "net/http"

module Mattermost
  module Messenger
    class Client
      attr_reader :webhook_url

      MESSAGE_COLOR = { success: "#4DD200", alert: "#E31B16" }.freeze

      def initialize(options: {})
        @options = options
        parse_options!
      end

      def send_messages!(options = {})
        if options.any?
          @options.merge!(options)
          parse_options!
        end

        uri = URI.parse(@webhook_url)

        client = Net::HTTP.new(uri.host, uri.port)
        client.use_ssl = true

        request = Net::HTTP::Post.new(uri.request_uri, { "Content-Type": "application/json" })
        request.body = message_body

        client.request(request)
      end

      private

      def parse_options!
        @webhook_url = @options[:webhook_url] || ENV.fetch("MATTERMOST_WEBHOOK_URL", nil)
        @title = @options.dig(:title, :text)
        @title_link = @options.dig(:title, :link)
        @type = @options[:type]
        @messages = @options[:messages]
      end

      def message_fields
        msg = [
          {
            short: false,
            title: @messages.first[:title],
            value: @messages.first[:content]
          }
        ]

        if @messages.count > 1
          msg = @messages.map do |message|
            {
              short: true,
              title: message[:title],
              value: message[:content]
            }
          end
        end

        msg
      end

      def message_body
        {
          attachments: [
            {
              fallback: @title,
              color: MESSAGE_COLOR[@type.to_sym],
              title: @title,
              title_link: @title_link,
              fields: message_fields
            }
          ]
        }.to_json
      end
    end
  end
end
