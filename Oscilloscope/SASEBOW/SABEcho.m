function O = SABEcho(Port)
% A = 65 , a = 97
%ECHO = [101 99 104 111 13 10]; % 'echo'
O=0;
ECHO = 'ECHO';
fwrite(Port,ECHO,'uchar');
fwrite(Port,13,'uint8');
pause(0.1);
Ack = fread(Port,4,'uchar');
if(strcmp(char(Ack'),'ECHO'))
    return;
else
    O = 1;
end

