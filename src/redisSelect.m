function [R, S] = redisSelect(R, db)

S = 'OK';
Value = [];
fopen(R);
if ~strcmp(R.Status, 'open')
  S = 'ERROR - NO CONNECTION';
  return;
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('SELECT %d', db)));

Response = strtrim(Response);


