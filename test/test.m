function test()

global R;

addpath('../src')

[R, M] = redisConnection();
assert_string(M, 'OK');

[Value, R, M] = redisPing(R);
assert_string(Value, 'PONG');

[R, M] = redisSet(R, 'foo', 'bar');
assert_string(M, 'OK');

[R, M] = redisSet(R, 'foo', 1234);
assert_string(M, 'ERROR - SET VALUE MUST BE A STRING');

[Value, R, M] = redisGet(R, 'foo');
assert_string(M, 'OK');
assert_string(Value, 'bar');

% single-output version
S = redisGet(R, 'foo');
assert_string(Value, 'bar');

redisDisconnect(R);

assert_string(R.status, 'closed');

disp('All tests passed!')

function assert_string(s1, s2, msg)

if nargin == 2,
  msg = 'Error!';
end

assert(strcmp(s1, s2) ~= 0, sprintf('Expected %s == %s', s1, s2))

function assert(cond, msg)

global R;

if nargin == 1,
  msg = 'Error!';
end

if ~cond,
  fclose(R);
  error(msg)
end
