function Parts = redisParseBulkReply(Reply)

Parts = {};

if Reply(1) == '*'
  ix = 2;
  [num_replies, n, ~, next_ix] = sscanf(Reply(ix : end), '%d', 1);
  
  if n ~= 1,
    return;
  end
  
  Parts = cell(num_replies, 1);
  
  ix = ix + next_ix + 2; % add length of \r\n
elseif Reply(1) == '$'
  ix = 2;
  num_replies = 1;
else
  return;
end

for rx = 1 : num_replies,
  [plength, n, ~, next_ix] = sscanf(Reply(ix : end), '%d', 1);
  if n ~= 1,
    return;
  end
  ix = ix + next_ix + 1; % add length of \r\n
  Parts{rx} = Reply(ix : ix + plength-1);
  ix = ix + plength + 3;
end
