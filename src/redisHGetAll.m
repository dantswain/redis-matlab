function [Struct, R, S] = redisHGetAll(R, key)

S = 'OK';
Fields = {};
Values = {};

if ~strcmp(R.Status, 'open')
  S = 'ERROR - NO CONNECTION';
  return;
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('HGETALL %s', key)));

if length(Response) == 0,
  S = 'ERROR - NO RESPONSE FROM SERVER';
  return
end

Parts = redisParseBulkReply(Response);

Fields = Parts(1 : 2 : end);
Values = Parts(2 : 2 : end);

Struct = cell2struct(Values, Fields, 1);
