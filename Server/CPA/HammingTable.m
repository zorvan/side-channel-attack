% Hamming Table
function Hamming_Table = HammingTable()
Hamming_Table = zeros(1,256,'uint8');
ipre = 0;
for i = 1:256
    num = uint8(0);
    tmp = uint16(i-1);
    while(tmp>0)
        num = num + uint8(bitget(tmp,1));
        tmp = bitsrl(tmp,1);
    end
    Hamming_Table(i) = num;
    k=floor(100*i/256);
    if(k>ipre)
        disp(['      ' num2str(k) '%']); 
        ipre=k;
    end
end
%save(['HammingTable256.mat'],'Hamming_Table');
