function WFM = TekWavFrm(VI)
% Get Waveform
fwrite(VI,'curve?');pause(0.01);
WFM = fread(VI,2506);pause(0.01);
%assignin('base','WaveForm',WFM);
