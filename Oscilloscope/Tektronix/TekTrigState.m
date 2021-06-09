function Status = TekTrigState(VI)
fwrite(VI,'TRIGger:STATE?');pause(0.01);
St = fread(VI,6);pause(0.01);
Status =  strcat(char(St'));