require_relative "base_redis_service"

class RedisSubscriberService < BaseRedisService
  attr_reader :channel
  attr_reader :messages
  attr_reader :messages_count

  def initialize(channel, messages_count = 5)
    @channel = channel
    @messages = []
    @messages_count = messages_count
  end

  def process
    connection.subscribe(channel) do |on|
      on.message do |channel, msg|
        messages.unshift(msg)
        Thread.current[:messages] = messages
      end
    end
  end
end
