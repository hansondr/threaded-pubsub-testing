require "redis"

class BaseRedisService
  REDIS_HOST = "127.0.0.1"

  def connection
    if !(defined?(@@connection) && @@connection)
      @@connection = Redis.new({ host: REDIS_HOST })
    end

    @@connection
  end
end
