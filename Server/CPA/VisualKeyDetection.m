function VisualKeyDetection(KN, W, HW)

disp('PoI');

offset1 = 8400;
offset2 = 9200;
coef    = 1600-2*KN;
Cb      = coef*KN+offset1;
Ce      = offset2+coef*KN;
CB      = mean(abs(corr(W(:,Cb:Ce),HW(:, :, KN))), 2);

if ~isempty(find(CB > 5e-3))
    
    [MXCB, IM]  = max(CB);
    MICB        = min(CB);
    step        = 2;
    Interval    = IM - 100:step:IM + 100;
    plot(Cb:Ce,CB);title('Best Location');disp('Press a Key');pause;
    plot(mean(abs(corr(W(:,Cb+Interval),HW(:, :, KN))), 1));title('Candidate Keys');disp('Press a Key');pause;
    LI          = length(Interval)*step;
    h           = figure;

    d = 100;
    for i = Interval
        PInterval   = i:i+d;
        CN          = corr(W(:, Cb+PInterval),HW(:, :, KN));
        CM          = mean(abs(CN));
        [MXCM,IX]   = max(CM);[MICM,~]    = min(CM);
        subplot(2, 1, 1);plot([IX IX], [MICM MXCM], 'r');hold on;plot(IX,MXCM, 'r*');
        subplot(2, 1, 1);plot(CM, 'k');hold off;
        subplot(2, 1, 1);title([num2str(floor(100 * (i - Interval(1)) / LI)) '% --> Key = ' num2str(IX - 1) '/' dec2bin(IX-1,8)]);
        subplot(2, 1, 2);rectangle('Position',[i-d-step MICB 2*d MXCB-MICB],'EdgeColor','white');hold on;
        subplot(2, 1, 2);rectangle('Position',[i-d      MICB 2*d MXCB-MICB],'EdgeColor','red');
        subplot(2, 1, 2);plot(CB, 'k');hold off;
        pause(0.01);
    end
    close(h);
else
    plot(CB);title('No Peak Detected!');
end
