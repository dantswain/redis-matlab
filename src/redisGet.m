function [Value, R, S] = redisGet(R, key)

S = 'OK';
Value = [];

if ~strcmp(R.Status, 'open')
  S = 'ERROR NO CONNECTION';
  return;
end

[Value, R, S] = redisCommand(R, sprintf('GET %s', key));

