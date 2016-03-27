redis_url = ENV["REDISCLOUR_URL"] || ENV["REDIS_URL"] || 'redis://localhost:6379'
redis_password = ENV["REDISCLOUD_PASSWORD"] || nil
database_url = ENV['DATABASE_URL'] || 'postgres://localhost:5432?pool=25'

Sidekiq.configure_server do |config|
  unless redis_password then
    config.redis = {
      url: redis_url
    }
  else
    config.redis = {
      url: redis_url,
      password: redis_password
    }
  end

  ActiveRecord::Base.establish_connection if database_url
end

Sidekiq.configure_client do |config|
  unless redis_password then
    config.redis = {
      url: redis_url
    }
  else
    config.redis = {
      url: redis_url,
      password: redis_password
    }
  end

  ActiveRecord::Base.establish_connection if database_url
end
