function OUT = WFAdjust(REF,WF)
[a,b] = size(WF);
OUT = zeros(a,b);

%parpool(2);
for i = 1:a
    [~,ix] = max(xcorr(REF,WF(i,:)));
    DIF = ix - b;
    if (DIF < 0)
        DIF = -DIF;
        OUT(i,:) = [WF(i,DIF+1:end) zeros(1,DIF)];
    else
        OUT(i,:) = [zeros(1,DIF) WF(i,1:end-DIF)];
    end
    disp(['Iteration Num.' num2str(i)]);
end

