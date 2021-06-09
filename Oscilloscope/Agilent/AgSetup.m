% GHADDAR - SASEBOW - SMART CARD
function waveform =AgSetup(VI,BUFSIZE,SR,SCALE,POS)

Delay = 0.01;
strMEM = [':ACQuire:POINts:ANALog ' num2str(BUFSIZE-1)];
fwrite(VI,strMEM);pause(Delay);
strSR = [':ACQuire:SRATe:ANALog ' SR];
fwrite(VI,strSR);pause(Delay);

%fwrite(VI,':ACQuire:SRATe:ANALog:AUTO ON');pause(Delay);
%fwrite(VI,':ACQuire:POINts:AUTO ON');pause(Delay);

fwrite(VI,':SYSTem:HEADer 0');pause(Delay);

fwrite(VI,':WAVeform:SOURce CHANnel2');pause(Delay);
fwrite(VI,':WAVeform:FORMat WORD');pause(Delay);

fwrite(VI,':WAVeform:STReaming ON');pause(Delay);
fwrite(VI,':WAVeform:BYTeorder LSBFirst');pause(Delay);
fwrite(VI,':DIGitize CHANnel2');pause(Delay);

% Time Base
strSCA = [':TIMebase:SCALe ' SCALE];
fwrite(VI,strSCA);pause(Delay);
strPOS = [':TIMebase:POSition ' POS];
fwrite(VI,strPOS);pause(Delay);
%fwrite(VI,':TIMebase:POSition -2E-3');pause(Delay);

% -------------------- Channels -----------------------
%fwrite(VI,':CHANnel1:PROBe:COUPling DC');pause(Delay);
%fwrite(VI,':CHANnel2:PROBe:COUPling DC');pause(Delay);
fwrite(VI,':CHANnel1:OFFSet 0');pause(Delay);
fwrite(VI,':CHANnel2:OFFSet 0');pause(Delay);

fwrite(VI,':CHANnel1:SCALe 1.0E+0');pause(Delay);
fwrite(VI,':CHANnel2:SCALe 5.0E-2');pause(Delay);

fwrite(VI,':CHANnel1:DISPlay ON');pause(Delay);
fwrite(VI,':CHANnel2:DISPlay ON');pause(Delay);

% -------------- Trigger ---------------------
%fwrite(VI,':TRIGger:MODE PWIDth');pause(Delay);
fwrite(VI,':TRIGger:MODE EDGE');pause(Delay);

%         ==== Delay Trigger ======
%                       TRIGER METHOD 1
fwrite(VI,':TRIGger:MODE DELay');pause(Delay);
fwrite(VI,':TRIGger:DELay:MODE TDELay');pause(Delay);
%fwrite(VI,':TRIGger:DELay:MODE EDELay');pause(Delay);
fwrite(VI,':TRIGger:DELay:ARM:SOURce CHANnel1');pause(Delay);
fwrite(VI,':TRIGger:DELay:ARM:SLOPe POSitive');pause(Delay);
fwrite(VI,':TRIGger:DELay:TDELay:TIME 21E-3');pause(Delay);
%fwrite(VI,':TRIGger:DELay:EDELay:COUNt 0');pause(Delay);
%fwrite(VI,':TRIGger:DELay:EDELay:SOURce CHANnel2');pause(Delay);
%fwrite(VI,':TRIGger:DELay:EDELay:SLOPe POSitive');pause(Delay);
fwrite(VI,':TRIGger:DELay:TRIGger:SOURce CHANnel2');pause(Delay);
fwrite(VI,':TRIGger:DELay:TRIGger:SLOPe POSitive');pause(Delay);
fwrite(VI,':TRIGger:LEVel CHANnel1,2.72E+0');pause(Delay);
fwrite(VI,':TRIGger:LEVel CHANnel2,180E-3');pause(Delay);

%                       TRIGER METHOD 2
%fwrite(VI,':TRIGger:LEVel CHANnel1,3E+0');pause(Delay);
%fwrite(VI,':TRIGger:LEVel CHANnel2,910E-3');pause(Delay);

%fwrite(VI,':TRIGger:EDGE:SOURce CHANnel1');pause(Delay);
%fwrite(VI,':TRIGger:AND:ENABle ON');pause(Delay);
%fwrite(VI,':TRIGger:AND:SOURce CHANnel1');pause(Delay);


fwrite(VI,':TRIGger:SWEep SINGle');pause(Delay);
%fwrite(VI,':TRIGger:SWEep TRIGgered');pause(Delay);
%fwrite(VI,':TRIGger:ADVanced:VIOLation:PWIDth:DIRection GTHan');pause(Delay);

% ------------------------- GUI --------------------------

preambleBlock = query(VI,':WAVeform:PREamble?');pause(Delay);
preambleBlock = regexp(preambleBlock,',','split');pause(Delay);
maxVal = 2^16;
% store all this information into a waveform structure for later use
waveform.Format = str2double(preambleBlock{1});     % This should be 1, since we're specifying INT16 output
waveform.Type = str2double(preambleBlock{2});
waveform.Points = str2double(preambleBlock{3});
waveform.Count = str2double(preambleBlock{4});      % This is always 1
waveform.XIncrement = str2double(preambleBlock{5}); % in seconds
waveform.XOrigin = str2double(preambleBlock{6});    % in seconds
waveform.XReference = str2double(preambleBlock{7});
waveform.YIncrement = str2double(preambleBlock{8}); % V
waveform.YOrigin = str2double(preambleBlock{9});
waveform.YReference = str2double(preambleBlock{10});
waveform.VoltsPerDiv = (maxVal * waveform.YIncrement / 8);      % V
waveform.Offset = ((maxVal/2 - waveform.YReference) * waveform.YIncrement + waveform.YOrigin);         % V
waveform.SecPerDiv = waveform.Points * waveform.XIncrement/10 ; % seconds
waveform.Delay = ((waveform.Points/2 - waveform.XReference) * waveform.XIncrement + waveform.XOrigin); % seconds
