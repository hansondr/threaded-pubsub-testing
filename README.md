# Redis PubSub experimentation

Following [Vipul A M's blog posting](http://blog.bigbinary.com/2015/05/09/verifying-pubsub-services-from-rails-redis.html)

## Run instructions:

```
% bundle
% rspec
```

## Caveats

If you get lucky the tests will both pass, if not only 1 will pass.  If you
run `redis-cli monitor` you will notice that the tests pass if the
**subscribe** is registered before the **publish** and fail if they are
received in the opposite order.  For the life of me I've been unable to ensure
that the **subscribe** occurs before the **publish**.

## Success Example

```
1473370163.681047 [0 127.0.0.1:45812] "subscribe" "test_channel"
1473370163.681313 [0 127.0.0.1:45814] "publish" "test_channel" "test value"
1473370164.182684 [0 127.0.0.1:45814] "set" "key" "test string"
1473370164.182813 [0 127.0.0.1:45814] "get" "key"
```

## Failure Example

```
1473370105.927470 [0 127.0.0.1:45768] "set" "key" "test string"
1473370105.927588 [0 127.0.0.1:45768] "get" "key"
1473370105.928608 [0 127.0.0.1:45768] "publish" "test_channel" "test value"
1473370105.928837 [0 127.0.0.1:45768] "subscribe" "test_channel"
```
