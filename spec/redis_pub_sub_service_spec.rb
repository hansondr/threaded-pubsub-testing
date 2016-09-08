require "rspec"
require_relative "../redis_writer_service"
require_relative "../redis_reader_service"
require_relative "../redis_publisher_service"
require_relative "../redis_subscriber_service"
require_relative "helpers/subscriber_helpers"

RSpec.describe "RedisPubSubService" do
  include SubscriberHelpers

  it "writes and reads value from Redis" do
    value = "test string"
    RedisWriterService.new("key", value).process

    expect(RedisReaderService.new("key").process).to eq(value)
  end

  it "writes and reads value using pubsub" do
    setup_subscriber("test_channel")
    value = "test value"

    with_subscriber do
      RedisPublisherService.new("test_channel", value).process
    end

    expect(message_from_subscription).to eq(value)

    teardown_subscriber
  end
end

