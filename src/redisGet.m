function [Value, R, S] = redisGet(R, key)

S = 'OK';
Value = [];

if ~strcmp(R.Status, 'open')
  S = 'ERROR NO CONNECTION';
  return;
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('GET %s', key)));

