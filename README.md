# redis-matlab

A [Redis](http://redis.io) client for Matlab, written in pure Matlab.  Dan Swain, dan.t.swain@gmail.com, 11/2012.

This client works by establishing a TCP connection to the specified Redis server and using the [Redis protocol](http://redis.io/topics/protocol).

This client is written in pure Matlab to provide the most portability with the least dependencies.  Because it is written purely in Matlab, it may not be as fast as a Matlab wrapper around, for example, a C or Java client.  As far as I know, no such client exists.

## Status

So far, only the Redis `GET` command works.  The other commands can be made to work by using, e.g., `redisCommand(R, redisCommandString('SET foo bar'))` (see below).

## Basic usage

Make a redis connection:

    R = redisConnection()                 % connect to localhost on port 6739
    R = redisConnection('foo.com')        % connect to foo.com on port 6739
    R = redisConnection('foo.com', 4242)  % connect to foo.com on port 4242

GET the value for a key (all values are assumed to be strings):

    redisGet(R, 'foo')  % value of foo

