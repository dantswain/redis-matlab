function [Value, R, S] = redisPing(R)

S = 'OK';
Value = [];

if ~strcmp(R.Status, 'open')
  S = 'ERROR - NO CONNECTION';
  return;
end

[Response, R, S] = redisCommand(R, redisCommandString('PING'));

Response = strtrim(Response);

if ~strcmp(Response, '+PONG')
  S = Response;
  return
end

Value = Response(2 : end);
