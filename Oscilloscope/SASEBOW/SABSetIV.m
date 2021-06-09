function [O,L]= SABSetIV(Port,IV)
IVHeader	= [128	08	0	0	16]; % 0x80 0x08 0x00 0x00 0x10(Data Length)
RHeader     = [128	192	0	0	10]; % 0x80 0xC0 0x00 0x00 0x10(Data Length)

Delay = 0.05;
O=1;
L=zeros(1,10,'uint16');
fwrite(Port,IVHeader,'uint8');pause(Delay);
Ack = fread(Port,1,'uint8');pause(0.01);
if(Ack == IVHeader(2))
    % WRITE IV
    fwrite(Port,IV,'uint16');pause(Delay);
    Ack = fread(Port,2,'uint8');pause(0.01);
    if(Ack(1) ~= 144 || Ack(2) ~= 0)
        disp('SASEBO-W Hardware Set-IV Failed!');
        O=0;
        return;
    end
    
    % READ
    fwrite(Port,RHeader,'uint8');pause(Delay);
    Ack = fread(Port,1,'uint8');pause(Delay);
    if (Ack == RHeader(2))
        L = fread(Port,10,'uint16');
        Ack = fread(Port,2,'uint8'); % Why Additional Read? Look into Smart-Card
        Ack = fread(Port,2,'uint8');
        if(Ack(1) ~= 144 || Ack(2) ~= 0)
            disp('SASEBO-W Encryption Hardware Failed!');
        end
    else
        disp('Error Writing RHeader To SASEBO-W');
    end
else
    O = 0;
end
