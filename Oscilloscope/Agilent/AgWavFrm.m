function [WFM,count] = AgWavFrm(VI,BUFSIZE)

if(strcmp(AgTrigState(VI),'+0'))
    disp('Was Not Triggered.');
    fclose(instrfind);delete(instrfind);
end
% Get Waveform
fwrite(VI,':WAVeform:DATA?');pause(0.01);
[WFM,count]= fread(VI,BUFSIZE,'int16');


