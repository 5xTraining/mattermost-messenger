# frozen_string_literal: true

require "factory_bot"
require "faker"

FactoryBot.define do
  factory :options, class: Hash do
    webhook_url { Faker::Internet.url }
    title { { text: Faker::Lorem.sentence, link: Faker::Internet.url } }
    type { "success" }
    messages do
      [
        { title: Faker::Lorem.sentence, content: Faker::Lorem.sentence },
        { title: Faker::Lorem.sentence, content: Faker::Lorem.sentence }
      ]
    end

    initialize_with { attributes }

    trait :with_env do
      after(:build) do |h|
        h[:webhook_url] = ENV.fetch("MATTERMOST_WEBHOOK_URL", nil)
      end
    end

    trait :without_webhook_url do
      after(:build) do |h|
        h.delete(:webhook_url)
      end
    end
  end
end
