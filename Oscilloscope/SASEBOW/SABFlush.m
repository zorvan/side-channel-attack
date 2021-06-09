function SABFlush(Port,RTS)
if(RTS)
    set(Port,'RequestToSend','on');
    pause(0.2);
    set(Port,'RequestToSend','off');
    pause(0.5);
end

k = get(Port,'BytesAvailable');
if(k>0)
    kp=fread(Port,k,'uint8');
end
