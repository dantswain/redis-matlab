function [R, S] = redisSet(R, pwd)

S = 'OK';

if ~isstr(pwd)
  S = 'ERROR - AUTH PWD MUST BE A STRING';
  return
end

if ~strcmp(R.status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

[Response, R, S] = redisCommand(R, redisCommandString(sprintf('AUTH %s', pwd)));

if strcmp(Response, '+OK')
  S = Response;
  return
end