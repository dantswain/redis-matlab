function [Output, R, S] = redisCommand(R, Cmd)

fprintf(R, Cmd);

% wait for bytes to show up
timeout = 1.0;
tic
while R.BytesAvailable == 0,
  pause(0.005)
  if toc >= timeout
    Output = '';
    S = 'ERROR - REDIS TIMEOUT';
    return;
  end
end

response = '';
tic
while R.BytesAvailable > 0,
  [chunk, ~, msg] = fread(R, R.BytesAvailable);
  response = [response char(chunk')];
  if toc >= timeout
    break
  end
end

Output = response;
S = 'OK';
