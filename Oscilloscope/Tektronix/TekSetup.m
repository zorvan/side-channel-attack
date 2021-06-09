function TekSetup(VI)

fwrite(VI,'DATa:SOUrce CH2');pause(Delay);
fwrite(VI,'DATa:ENCdg RPBinary');pause(Delay);
fwrite(VI,'DATa:WIDth 1');pause(Delay);

% Write Settings
%fwrite(VI,'HORizontal:SCAle 10.0E-6');
fwrite(VI,'HORizontal:SCAle 5.0E-6');pause(Delay);
fwrite(VI,'HORizontal:MAIn:POSition 3.371E-3');pause(Delay);
%fwrite(VI,'HORizontal:MAIn:POSition 3.382E-3');

%Channel
fwrite(VI,'CH1:COUpling DC');pause(Delay);
fwrite(VI,'CH2:COUpling DC');pause(Delay);
fwrite(VI,'CH1:SCAle 1.0E0');pause(Delay);
fwrite(VI,'CH2:SCAle 2.0E-1');pause(Delay);

%Trigger
fwrite(VI,'TRIgger:MAIn:TYPe Pulse');pause(Delay);
fwrite(VI,'TRIgger:MAIn:PULse:SOUrce CH1');pause(Delay);
fwrite(VI,'TRIgger:MAIn:PULse:WIDth:WHEn OUTside');pause(Delay);
fwrite(VI,'TRIgger:MAIn:MODe NORmal');pause(Delay);
fwrite(VI,'TRIgger:MAIn:EDGE:COUpling HFRej');pause(Delay);

fwrite(VI,'ACQuire:STOPAfter SEQuence');pause(Delay);
