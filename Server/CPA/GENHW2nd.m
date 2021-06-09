function H = GENHW2nd(Plain)

% -------------------- Initialization -------------------

% RKey = reshape([201 xxx 129 046 ...
%                 082 163 033 139 ...
%                 021 101 211 xxx ...
%                 076 211 141 079],4,4);
tic
RKey = reshape([125 066 117 167 ...
                150 045 013 006 ...
                169 015 011 251 ...
                090 227 208 107],4,4);

disp('-     Initialization....');
[N,BLOCK]       = size(Plain);
H               = zeros(N,256,BLOCK);

HammingTable    = load('HammingTable256.mat');
HammingTable    = HammingTable.Hamming_Table;
sbox            = load('aes-sbox.mat');
sbox            = sbox.s_box;
polymat         = load('aes-polymat.mat');
polymat         = polymat.poly_mat;

% ------------------- Begin Computation ----------------------

disp('Generate Hamming Weight ...');
parfor Sample=1:N
    state = bitxor(reshape(Plain(Sample,:),4,4),RKey);
    state = sbox(state+1);
    state = cycle (state, 'left'); %shift_rows(state);
    state = mix_columns(state, polymat);
    for Guess=1:256
        GS = (Guess-1)*ones(1,16);
        % Model : Hamming Distance of the SubBytes input/output
        T   = bitxor(reshape(state,1,16),GS); % add-roundkey
        T   = sbox(T+1);
        H(Sample,Guess,:) = HammingTable(1+T);
    end
end
toc
%close(h);
%save([FileName '-HW.mat'],'H');
