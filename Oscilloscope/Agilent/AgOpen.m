function VI = AgOpen(Serial,BufferSize)

% Open Interface
VI = visa('agilent',Serial);
set(VI,'InputBufferSize',BufferSize);
fopen(VI);

fwrite(VI,'*CLS');
% Get ID
A = query(VI,'*IDN?');
disp(char(A));

fwrite(VI,'*RST');