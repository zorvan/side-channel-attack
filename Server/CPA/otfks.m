function Key = otfks(SubKey, sbox)
SubKey      = reshape(SubKey,4,4);
Key         = zeros(4, 4);
Key(:,4)    = bitxor(SubKey(:, 4), SubKey(:, 3));
Key(:,3)    = bitxor(SubKey(:, 3), SubKey(:, 2));
Key(:,2)    = bitxor(SubKey(:, 2), SubKey(:, 1));
Key(:,1)    = bitxor(SubKey(:, 1), bitxor(sbox(Key([2 3 4 1], 4) + 1)', [1 0 0 0]'));
Key         = reshape(Key,1,16);