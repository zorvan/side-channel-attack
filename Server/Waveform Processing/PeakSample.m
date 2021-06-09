function FF = PeakSample(WF,Window)
[L,N] = size(WF);
M = N/Window;
FF = zeros(L,M-1);
for i = 1:L
    WFI = WF(i,:);
    parfor j=1:M-1
        Begin       = j*Window;
        End         = Begin  + Window;
        [~,ix]      = max(abs(WFI(Begin+1:End)));
        FF(i,j)     = WFI(Begin+ix);
    end
%    plot(FF(i,:));
%    title(['WF ' num2str(i)]);
%    disp('press a key...');
%    pause
end
