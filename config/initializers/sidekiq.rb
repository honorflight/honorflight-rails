redis_url = ENV["REDISCLOUR_URL"] || ENV["REDIS_URL"] || 'redis://localhost:6379'
database_url = ENV['DATABASE_URL'] || 'postgres://localhost:5432?pool=25'

Sidekiq.configure_server do |config|
  config.redis = {
    url: redis_url
  }

  ActiveRecord::Base.establish_connection if database_url
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: redis_url
  }

  ActiveRecord::Base.establish_connection if database_url
end
