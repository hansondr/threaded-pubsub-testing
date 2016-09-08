require_relative "base_redis_service"

class RedisWriterService < BaseRedisService
  attr_reader :key, :value

  def initialize(key, value)
    @key = key
    @value = value
  end

  def process
    connection.set(key, value)
  end
end
