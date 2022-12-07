# frozen_string_literal: true

[
  "mattermost/messenger",
  "mattermost/messenger/version",
  "mattermost/messenger/client"
].each do |mod|
  require mod
rescue LoadError
  puts "modules load failed"
end
