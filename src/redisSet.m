function [R, S] = redisSet(R, key, value)

S = 'OK';

if ~isstr(value)
  S = 'ERROR - SET VALUE MUST BE A STRING';
  return
end

%fopen(R);

if ~strcmp(R.Status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('SET %s %s', key, value)));

if strcmp(Response, '+OK')
  S = Response;
  return
end
