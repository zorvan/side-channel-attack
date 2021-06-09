function vu = TekOpen(Serial,BufferSize)

Delay = 0.01;

% Open Interface
vu = visa(Serial);
set(vu,'InputBufferSize',BufferSize);
fopen(vu);pause(Delay);

% Get ID
fwrite(VI,'*idn?');pause(Delay);
A = fread(VI,50);pause(Delay);
disp(char(A)');

% Get Model
Get Device Model
fwrite(VI,'Data?');
A = fread(VI);
disp(char(A)');
