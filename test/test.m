function test()

global R;

addpath('../src')

[R, M] = redisConnection();
assert_string(M, 'OK');

[Value, R, M] = redisPing(R);
assert_string(Value, 'PONG');

[R, M] = redisSelect(R, 0);  % select 0

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

[R, M] = redisHSet(R, 'foo1', 'aa', '1234');
[R, M] = redisHSet(R, 'foo1', 'bb', 'bb1234');
assert_string(M, 'OK');

[Value, R, M] = redisHGet(R, 'foo1','aa');
assert_string(M, 'OK');
assert_string(Value, '1234');

[Value, R, M] = redisHGetAll(R, 'foo1');
disp(Value)

redisDisconnect(R);

disp('All tests passed!')

function assert_string(s1, s2, msg)

if nargin == 2,
  msg = 'Error!';
end

if (iscell(s1))
    assert(strcmp(s1, s2) ~= 0, sprintf('Expected %s == %s', s1{1}, s2))
else
    assert(strcmp(s1, s2) ~= 0, sprintf('Expected %s == %s', s1, s2))
end

function assert(cond, msg)

global R;

if nargin == 1,
  msg = 'Error!';
end

if ~cond,
  fclose(R);
  error(msg)
end
