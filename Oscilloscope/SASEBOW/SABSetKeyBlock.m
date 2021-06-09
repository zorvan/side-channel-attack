function O = SABSetKey(Port,Key)
KeyHeader	= [128	18	0	0	16]; % 0x80 0x12 0x00 0x00 0x10(Data Length)

O = 1;
fwrite(Port,KeyHeader,'uint8');pause(1);
Ack = fread(Port,1,'uint8');pause(0.1);
if(Ack == KeyHeader(2))
    fwrite(Port,Key,'uint8');pause(0.1);
    Ack = fread(Port,2,'uint8');pause(0.1);
    if(Ack(1) ~= 144 || Ack(2) ~= 0)
        disp('SASEBO-W Hardware Set-Key Failed!');
    end;
else
    O = 0;
end
