function Port = SABOpen()
% Define Serial Port
Port = serial('COM10','BaudRate',115200,'DataBits',8,'Parity','none','StopBits',1,'DataTerminalReady','off','RequestToSend','off','TimeOut',10);
%Open Serial Port
fopen(Port);
% SABFlush(Port,1);
