function test()

addpath('../src')

[R, M] = redisConnection();
assert_string(M, 'OK');

[R, M] = redisSet('foo', 'bar');
assert_string(M, 'OK');

[Value, R, M] = redisGet('foo');
assert_string(M, 'OK');
assert_string(Value, 'bar');

function assert_string(s1, s2, msg)

assert(strcmp(s1, s2) == 0, msg)

function assert(cond, msg)

if nargin == 0,
  msg = 'Error!'
end

if ~cond,
   error(msg)
end
