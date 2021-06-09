function H = GENHW(Plain)

% -------------------- Initialization -------------------

disp('-     Initialization....');
[N,BLOCK]   = size(Plain);
H           = zeros(N,256,BLOCK);

load('HammingTable256.mat');
HT = Hamming_Table;clear Hamming_Table;
load('aes-sbox.mat');
SBX = s_box; clear s_box;

% ------------------- Begin Computation ----------------------

disp('Generate Hamming Weight ...');
parfor Guess=1:256
    for Byte = 1:BLOCK
        for Sample=1:N
            % Model : Hamming Distance of the SubBytes input/output
            T  = bitxor(Plain(Sample,Byte),Guess-1); % add-roundkey
            T = SBX(1+T);
            H(Sample,Guess,Byte) = HT(1+T);
        end
    end
    disp(['Guess num.' num2str(Guess) ' Done.'])
end

%save([FileName '-HW.mat'],'H');
