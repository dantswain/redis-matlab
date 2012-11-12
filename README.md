# redis-matlab

A [Redis](http://redis.io) client for Matlab, written in pure Matlab.  Dan Swain, dan.t.swain@gmail.com, 11/2012.

This client works by establishing a TCP connection to the specified Redis server and using the [Redis protocol](http://redis.io/topics/protocol).

This client is written in pure Matlab to provide the most portability with the least dependencies.  Because it is written purely in Matlab, it may not be as fast as a Matlab wrapper around, for example, a C or Java client.  As far as I know, no such client exists.

## Status

So far, only a few commands work (`GET`, `SET`, and `PING`).  Other commands could be made to work by using, e.g., `redisCommand(R, redisCommandString('SET foo bar'))` (see below).

## Basic usage

All simple values are assumed to be strings unless otherwise specified.  It's up to you to create/parse the strings.

Make a redis connection:

    R = redisConnection()                 % connect to localhost on port 6739
    R = redisConnection('foo.com')        % connect to foo.com on port 6739
    R = redisConnection('foo.com', 4242)  % connect to foo.com on port 4242

PING to check the connection:

    [Value, R, Status] = redisPing(R)         % Value = 'PONG'

SET the value of a key:

    [R, Status] = redisSet(R, 'foo', 'bar')   % Status = 'OK'

GET the value for a key:

    [Value, R, Status] = redisGet(R, 'foo')   % Value = 'bar', Status = 'OK'

HSET the value of a hash field:

    [R, Status] = redisHSet(R, 'some_hash', 'field1', 'abcd')   % Status = 'OK'

HGET the value of a hash field:

    [Value, R, Status] = redisHGet(R, 'some_hash', 'field1')    % Value = 'abcd', Status = 'OK'

Disconnect the client:

    redisDisconnect(R);
