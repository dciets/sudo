require_relative 'common'

Lita.configure do |config|
  config.robot.name = "sudo"
  config.robot.log_level = :debug
  config.robot.admins = []
  config.robot.adapter = :slack

  config.adapters.slack.token = ENV['SLACK_TOKEN']

  config.redis[:host] = "redis"
  config.http.port = 3000

  config.handlers.google_images.google_cse_id = ENV['CSE_ID']
  config.handlers.google_images.google_cse_key = ENV['GOOGLE_API_KEY']
  config.handlers.timezone.default_zone = 'Canada/Eastern'
  config.handlers.youtube_me.api_key = ENV['GOOGLE_API_KEY']
  config.handlers.youtube_me.top_result = true
end
