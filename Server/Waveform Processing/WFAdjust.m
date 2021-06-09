function OUT = WFAdjust(REF,WF)
L = size(REF,2);
[~,ix] = max(xcorr(REF,WF));
DIF = ix - L;
if (~DIF)
    OUT = REF;
elseif (DIF < 0)
    DIF = -DIF;
    OUT = [WF(DIF+1:end) zeros(1,DIF)];
else
    OUT = [zeros(1,DIF) WF(1:end-DIF)];
end
