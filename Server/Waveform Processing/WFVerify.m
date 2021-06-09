function WFVerify()
clc
debugmode   = 0;

%TotalFault  = [];
SWF         = [];
SPLN        = [];

Start       = 1;
End         = 800;
SPF         = 100;   % Samples Per File

disp('Loading Plain Texts...');
%load('PlainBGAN.mat');
%load('FRDetect.mat');
load('SRDetect.mat');
for i=Start:End
    tic
    disp(['Loading Waveform Num.' num2str(i)]);
    load(['BGAN-16MHz-' num2str(i) '.mat']);
    load(['PLAIN-BGAN-' num2str(i) '.mat']);

    % -------------- Invalid Samples --------------

    Fault   = [];
    A       = mean(abs(WF),2);
    B       = mean(A);
    [Fault,~]   = find(abs(A-B)>B/10);

    if ~isempty(Fault)
        plot(mean(abs(WF),2));hold on;
        line(Fault,mean(abs(WF(Fault,:)),2),'Color','r');hold off;
        title(['Anomaly Detection Num.' num2str(i)]);pause(1);
        Fault   = Fault';
        disp(['  Purging ' num2str(length(Fault)) ' Anomalous Samples']);
        Beep(3);
    end

    disp('  Primary Filter...');

    WF      = WF - mean(WF,2);
    % WF      = SmartFilt(WF,5e7);
    %WF      = WF(:,0.5e5:2.5e5);    % Trim First Round
    WF      = WF(:,2.5e5:4.5e5);    % Trim First Round

    % -------------- Major Missalignment -----------

    % load('NOPDetect.mat');

    S           = 1:size(WF,1);
    S(Fault)    = [];
    RoundStart  = size(WF,2); + length(SR);
    %TTR         = floor((RoundStart*3/2));
    for j = S
        WW          =   WF(j,:);
        XC          =   xcorr(WW,SR);
%        XC(1:1.46e5)   =   [];
        %[~,XCI]     =   find(XC > 1.5e11);                  % Amplitude Threshold
        [MCX,XCI]     =   max(XC);
        if MCX < 4e11 % isempty(XCI)
            Fault = [Fault j];
        else
            DIF = XCI(1) - RoundStart;
            if (abs(DIF) > RoundStart/10) %  Tolerance = 10%
                Fault = [Fault j];
                if debugmode
                    plot(WW,'r');title(['File: ' num2str(i) '  Sample:' num2str(j)]);
                    %pause(0.02);
                end
            else % Adjusting
                %plot(XC);hold on;title(num2str(DIF));
                if (DIF < 0)
                    WF(j,:) = [zeros(1,-DIF) WW(1:end+DIF)];
                elseif(DIF > 0)
                    WF(j,:) = [WW(DIF+1:end) zeros(1,DIF)];
                end
            end
        end
    end
    disp(['  Purging ' num2str(length(Fault)) ' Missaligned Samples']);

    WF = WF(:,7e4:10.25e4); % SBOX

    %spectrogram(WF(1,:),kaiser(5000,5),4000,2^16,5e7,'yaxis');ax = gca;ax.YScale = 'log';view(-45,65);
    
    % ----------------------------------
    
    %     A = MeanSample(abs(WF),2000,1200);
    %     A = abs(A-mean(A)) > 6e5;
    %     B = [];
    %     for j = 1:S
    %         if ~isempty(find(A(j,1:20),1))
    %             B = [B j];
    %         end
    %     end
    % ----------------------------------
    
    %     load('NOPDetect.mat');
    %     Y = abs(xcorr(WF(3,:),NOP));
    %     Y = Y(2^17:end);
    %     Z = MeanSample(Y,5000,4000);plot(Z)
    
    % ----------------------------------

%     disp('  POI Detection...');
%     WF  = WF(:,2e4:9e4); % For 2nd Round
%     WFF = zeros(size(WF,1)-length(Fault),1.2e4);
%     SR  = load('SRDetection.mat');SR = SR.SR;
%     S   = 1:size(WF,1);
%     S(Fault) = [];
%     for j = S
%         XC = xcorr(WF(j,:),SR);
%         XC(1:6.9e4) = [];
%         [~,XCM] = max(XC);
%         if (XCM>58000) % Exeed Matrix Dimension : length(WF) - Length(Sbox) = 58000
%             Fault = [Fault j];
%             continue;
%         end
%         WFF(j,:) = WF(j,XCM(1)+1:XCM(1)+1.2e4);
%         
%         if(debugmode && ~mod(j,20))
%             subplot(2,1,1);plot(XC);title(num2str(j));hold on;
%             subplot(2,1,1);line([XCM(1) XCM(1)],[-1e11 1.5e11],'Color','r');hold off;
%             
%             subplot(2,1,2);plot(zeros(1,1));
%             subplot(2,1,2);line([XCM(1) XCM(1)],[-2e4 2e4],'Color','r');hold on;
%             subplot(2,1,2);rectangle('Position',[XCM(1) -1.1e4 1.2e4 2.2e4],...
%                                      'EdgeColor','g','Curvature',0.1,...
%                                      'LineWidth',1,'FaceColor',[0 .7 .7]);
%             subplot(2,1,2);plot(WF(j,:),'b');hold off;
%             pause(1);
%         end
%     end
     disp(['Time = ' num2str(toc)]);
%     WFF(Fault,:)    = [];
%      TotalFault      = [TotalFault Fault + ((i-1) * SPF)];

%     SWF             = [SWF;WFF];
      WF(Fault,:)     = [];
      Plain(Fault,:)  = [];
%    save(['PureWaves1R-' num2str(i) '.mat']);
      SWF             = [SWF;WF];
      SPLN            = [SPLN;Plain];  
      %if ~mod(i,200)
      %    Beep(5);
      %    save(['PureWaves1R-' num2str(floor(i/200)) '.mat'],'SWF','-v7.3');
      %    SWF = [];
      %end
%     clear WFF;
end

%disp (['Total Number of Faults = ' num2str(length(TotalFault))]);

%Plain(TotalFault,:) = [];

    % ----------------------------------
    
    %    WFF = WF(:,4e4:9e4);
    
    %     for j=1:size(WFF,1)
    %         subplot(2,1,1);plot(WF(j,:));title(num2str(j));hold on;
    %         rectangle('Position',[4e4 -5e3 5e4 1e4],'EdgeColor','r');hold off;
    %         subplot(2,1,2);plot(WFF(j,:));title(num2str(j));
    %         pause;
    %     end
    
    % ----------------------------------
%     
%     if (i==Start)
%         disp('Choose Reference Waveform :');
%         Vindex = WFChoose(WF);
%         REF = WF(Vindex,:);%REF = [zeros(1,1.35e4) REF(1.3e4:2.4e4) zeros(1,1.35e4)];% Refine the REF
%         LenF = size(REF,2);
%         Distance = LenF/10;
%     end
%     
%     LocalFault = [];
%     for k = 1:S
%         WW = WF(k,:);
%         mxc = xcorr(REF,WW);
%         %plot(mxc);pause(0.2);
%         [vx,ix] = max(mxc);
%         DIF=ix - LenF;
%         if (abs(DIF) > Distance || max(mxc) < Threshold)
%             Fault = [Fault;(i-1)*S + k];
%             LocalFault = [LocalFault;k];
%             disp(['*  Bad Waveform Detected @' num2str(Fault(end))]);
%             if (debugmode)
%                 plot(mxc,'r');pause(1);
%                 plot(WF(k,:),'b');
%                 title(['File = ' num2str(i) '  Waveform = ' num2str(k)]);
%                 DIF
%                 max(mxc)
%                 disp('press any key ...');pause;
%             end
%         else % Adjusting
%             if (DIF < 0)
%                 DIF = - DIF;
%                 WF(k,:) = [WW(DIF+1:end) zeros(1,DIF)];
%             elseif(DIF > 0)
%                 WF(k,:) = [zeros(1,DIF) WW(1:end-DIF)];
%             end
%         end
%     end
%     disp(['Number of Local Faults (in 200) : ' num2str(length(LocalFault))]);
%     WF(LocalFault,:)=[];
%     SWF = [SWF;WF];
% end
% clear WF;
% 
% Plain(Fault,:)=[];
% %Plain(size(SWF,1)+1:end,:)=[];
% %Plain = Plain((Start-1)*S+1:End*S,:);
% 
% disp(['Number of Total Faults Detected : ' num2str(length(Fault))]);
% 
% disp('Filtering... ');
% M2W = mean(SWF,2);
% plot(M2W);
% QTh = input('Base on the Figure, Input the Threshold : ');
% QFault = find(M2W < Qth);
% %plot(SWF(QFault(1),:));
% SWF(QFault,:) = [];
% Plain(QFault,:) = [];
% 
disp('Saving the Results...');
save('PurePlain2R.mat','SPLN');
save('PureWaves2R.mat','SWF','-v7.3');

% ------------------------------------------

function Beep(n)
for i = 1:n
    beep;pause(i/(n*5));
end
