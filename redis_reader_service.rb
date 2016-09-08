require_relative "base_redis_service"

class RedisReaderService < BaseRedisService
  attr_reader :key

  def initialize(key)
    @key = key
  end

  def process
    connection.get(key)
  end
end
