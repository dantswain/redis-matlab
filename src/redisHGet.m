function [V, R, S] = redisHGet(R, key, field)

S = 'OK';
V = [];

if ~strcmp(R.status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('HGET %s %s', key, field)));

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
V = parts{2};
