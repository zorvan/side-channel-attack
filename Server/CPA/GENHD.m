function H = GENHD(Plain)

% -------------------- Initialization -------------------

disp('-     Initialization....');
[N,BLOCK]   = size(Plain);
H           = zeros(N,256,BLOCK);

HammingTable=load('HammingTable256.mat');
HammingTable=HammingTable.Hamming_Table;
sbox=load('aes-sbox.mat');
sbox=sbox.s_box;

% ------------------- Begin Computation ----------------------

disp('Generate Hamming Distance ...');
parfor Guess=1:256
    for Byte = 1:BLOCK
        for Sample=1:N
            % Model : Hamming Distance of the SubBytes input/output
            Before  = bitxor(Plain(Sample,Byte),Guess-1); % add-roundkey
            After   = sbox(1+Before);             % Subtitution Box
            T       = bitxor(After,Before);               % Hammind Distance

            H(Sample,Guess,Byte) = HammingTable(1+T);
        end
    end
    disp(['Guess num.' num2str(Guess) ' Done.'])
end

%save([FileName '-HD.mat'],'H');
