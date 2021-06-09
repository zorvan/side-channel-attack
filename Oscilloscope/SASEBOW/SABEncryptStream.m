function Cipher = SABEncrypt(Port,Plain)
O = 0;
Delay = 0.1;
RHeader	= [128	192	0	0	16]; % 0x80 0xC0 0x00 0x00 0x10(Data Length)

% [128	4	4	1	16] for Hardware-Like
% [128	4	4	0	16] for Byte-Oriented
WHeader	= [128	4	4	1	02]; % 0x80 0x04 0x04 0x00 0x10(Data Length)

fwrite(Port,WHeader,'uint8');   pause(Delay);
Ack = fread(Port,1,'uint8');    pause(Delay);
if(Ack ~= WHeader(2))
    disp('Error Writing WHeader To SASEBO-W');
end

fwrite(Port,Plain,'uint8');pause(Delay);
Ack = fread(Port,2,'uint8');pause(Delay);
if(Ack(1) ~= 159 || Ack(2) ~= 16)
    disp('Error Writing Plain To SASEBO-W');
end;
    
% Read

fwrite(Port,RHeader,'uint8');pause(Delay);
Ack = fread(Port,1,'uint8');pause(Delay);

if (Ack == RHeader(2))
    O = fread(Port,16,'uint8');pause(Delay);
    Ack = fread(Port,2,'uint8');
    if(Ack(1) ~= 144 || Ack(2) ~= 0)
        disp('SASEBO-W Encryption Hardware Failed!');
    end;
else
    disp('Error Writing RHeader To SASEBO-W');
end

Cipher = O;