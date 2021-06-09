function Cipher = SABAuthen(Port,Plain)
O = 0;

Hplain = dec2hex(Plain,2);
Splain=[];
for i=1:length(Plain)
    Splain=[Splain Hplain(i,:)];
end

count=0;
fwrite(Port,'AUTN','uchar');
fwrite(Port,13,'uint8');
pause(0.01);
Ack = fread(Port,4,'uint8');
if(strcmp(char(Ack'),'AUTN'))   % Did I get 'AUTN' Response?
    fwrite(Port,Splain,'uchar'); % 32 Bytes
    pause(0.1);
    Ack = fread(Port,32,'uint8');
    if(char(Ack') == Splain)
        fwrite(Port,'OK','uchar');
        fwrite(Port,13,'uint8');
        pause(0.01);
        Ack = fread(Port,7,'uint8');
        if(~strcmp(char(Ack'),'SUCCESS'))
            disp('Error! Computation Problem in USIM !');
            O=1;
         end % USIM SUCCESS
    else % Error in Plain Echo
        fwrite(Port,'KO','uchar');
        disp('Error! Problem in Sending Plain Text!');
        count = count + 1;
        if (count==3)
            disp('*** Reset the Device and Try Again! ***');
            O=1;
        end
    end % PLAIN ECHO
else % AUTN Echo Problem
    disp('Error! No Answer to AUTN Command!');
    O=1;
end % AUTN

Cipher = O;

