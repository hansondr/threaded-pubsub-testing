require_relative "../../redis_subscriber_service"

module SubscriberHelpers
  THREAD_PROCESS_TIMEOUT = 0.5

  def setup_subscriber(channel = "test_channel")
    @subscriber = Thread.new { RedisSubscriberService.new(channel).process }
  end

  def teardown_subscriber
    @subscriber.kill
  end

  def with_subscriber
    yield
    @subscriber.join(THREAD_PROCESS_TIMEOUT)
  end

  def message_from_subscription
    @subscriber[:messages].first
  end
end
