# frozen_string_literal: true

require "factory_bot"
require "faker"

FactoryBot.define do
  factory :options, class: Hash do
    webhook_url { Faker::Internet.url }
    title { Faker::Lorem.sentence }
    type { %w[success alert].sample }
    messages do
      [
        { title: Faker::Lorem.sentence, content: Faker::Lorem.sentence },
        { title: Faker::Lorem.sentence, content: Faker::Lorem.sentence }
      ]
    end

    initialize_with { attributes }
  end
end