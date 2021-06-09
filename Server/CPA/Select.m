
clc
debugmode   = 0;

Fault       = [];
SWF         = [];
REF         = W(1, :);
LenF        = size(W, 2);
Distance    = LenF / 10;

for k = 1:size(W,1)
    WW      = W(k, :);
    mxc     = xcorr(REF, WW);
    %plot(mxc);pause(0.2);
    [vx,ix] = max(mxc);
    DIF     = abs(ix - LenF);
    if (DIF > Distance || max(mxc) < 7e11)
        Fault = [Fault; k];
        disp(['*  Bad Waveform Detected @' num2str(k)]);
        if (debugmode)
            plot(mxc, 'r');pause(0.5);
            plot(W(k, :), 'b');
            title(['Waveform = ' num2str(k)]);
            DIF
            max(mxc)
            pause(0.5);%disp('press any key ...');pause;
        end
    else % Adjusting
        if (DIF < 0)
            DIF     = -DIF;
            W(k, :) = [WW(DIF+1:end) zeros(1,DIF)];
        elseif(DIF > 0)
            W(k, :) = [zeros(1,DIF) WW(1:end-DIF)];
        end
    end
end

disp(['Filtering...']);
W(Fault, :)      = [];
HW(Fault, :, :)  = [];
%Plain(Fault, :)  = [];
