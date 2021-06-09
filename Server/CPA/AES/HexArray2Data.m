function [plain,cipher] = HexArray2Data(MaxLine)

h = fopen('plaincipher.txt','r');
nextline = '';
j=0;
plain= zeros(MaxLine,16);
cipher= zeros(MaxLine,16);

while (ischar(nextline) && j<MaxLine)
    j=j+1;
    Splain = fgetl(h);
    Scipher = fgetl(h);
    for i=1:3:47
        k=1+int8(i/3);
        plain(j,k) = hex2dec(Splain(i:i+1));
        cipher(j,k) = hex2dec(Scipher(i:i+1));
    end
end
plain = uint8(plain);
cipher= uint8(cipher);
fclose(h);
