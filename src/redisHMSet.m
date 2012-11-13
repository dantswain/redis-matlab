function [R, S] = redisHMSet(R, key, fields, values)

S = 'OK';

if ~iscell(fields) || ~iscell(values) || numel(fields) ~= numel(values)
  S = 'ERROR - FIELDS AND VALUES MUST BE CELL ARRAYS OF EQUAL SIZE';
  return
end

if ~strcmp(R.status, 'open')
  S = 'ERROR - NO CONNECTION';
  return
end

cmd = sprintf('HMSET %s', key);

for nf = 1 : numel(fields)
  if ~isstr(fields{nf}) || ~isstr(values{nf})
    S = 'ERROR - FIELDS AND VALUES MUST BE CELL ARRAYS OF STRINGS';
    return
  end
  cmd = sprintf('%s %s %s', cmd, fields{nf}, values{nf});
end

[Response, R, S] = redisCommand(R, redisCommandString(cmd));

if Response(1) ~= '+'
  S = Response;
  return
end
