function SerialReset(Port)
Delay = 0.01;
fclose(Port);pause(Delay);
fopen(Port);pause(Delay);
