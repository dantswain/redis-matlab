function [Value, R, S] = redisGet(R, key)

S = 'OK';
Value = [];

if ~strcmp(R.Status, 'open')
  S = 'ERROR - NO CONNECTION';
  return;
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('GET %s', key)));

if Response(1) == '-'
  S = Response;
  return
end

if Response(1) ~= '$'
  S = Response;
  return
end

% response $-1 means nonexistant key
if Response(2) == '-'
  S = 'ERROR - NONEXISTANT KEY'
  return
end

parts = regexp(Response, '\r\n', 'split');
Value = parts{2};
