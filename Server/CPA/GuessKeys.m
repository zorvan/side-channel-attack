function GuessKeys()
sbox = load('aes-sbox.mat');sbox = sbox.s_box;
Keys = [];
parfor i = 0:255
    for j = 0:255
        RKey = [201 i   129 046 ...
                082 163 033 139 ...
                021 101 211   j ...
                076 211 141 079];

        Keys = [Keys;otfks(RKey,sbox)];
    end
end
save('GuessKey.mat','Keys');
dlmwrite('GuessKeyHex.txt',Keys,'delimiter','\t','precision','%x')
        