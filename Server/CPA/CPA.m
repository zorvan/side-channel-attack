function CPA()

clc

addpath(genpath('./AES'));
%WfmAddr = '../../Waveforms/BGAN1RSBOX-10800/';
%WfmAddr = '../../Waveforms/BGAN-40K-A/';
WfmAddr = '../../Waveforms/';

% -------------------- Reading Signals -------------------

disp('Loading Plain Text... ');
load([WfmAddr 'PurePlain1R.mat']);

disp('Loading Waveform');
load([WfmAddr 'PureWaves1R.mat']);

%W = W(:,7000:36000);

% Very Fine Tuning
[m,n]     = size(W);
disp('Fine Alignment');
df = [];
tic

for i=1:m
    [~,b]=max(xcorr(W(i,:),W(1,:)));
    dif = b-n;
    df = [df dif];
    d = dif;
    
    if d > 0
        W(i,:) = [W(i,d+1:end) zeros(1,d)];
    elseif d < 0
        W(i,:) = [zeros(1,-d) W(i,1:end+d)];
    end

    if ~mod(i,round(m/100))
        disp(['  Alignment :' num2str(round(100*i/m)) '%  in ' num2str(toc) ' seconds']);
    end
end

Anomalies = find(abs(df)>200);

if ~isempty(Anomalies)
    plot(df);hold on;
    plot(Anomalies,df(Anomalies),'r*');hold off;
    title('Anomalied Detected');
    %Plain(Anomalies,:)  = [];
    Plain(Anomalies,:,:)  = [];
    W(Anomalies,:)      = [];
    %df(Anomalies) = [];
end

disp(' Generate Power Model of Round');
HD = GENHD(Plain);
HW = GENHW(Plain);
%HW = GENHW2nd(Plain);
%save('HammingTable1st.mat','HW');
%load('HammingTable1st.mat');
%load('HammingTable2nd.mat');

% FILTER
%www = SmartFilt(W,1:25e4);

% ------------------- Begin Computation ----------------------

disp('Finding The Keys ...');
VisualKeyDetection(1, W, HW);

% ------------------   Auxiliary Function ---------------------
