function www = SmartFilt(W,SR)
%wfft(W(1,:),SR);hold on;

% bpFilt = designfilt('bandpassfir', ...
%                     'StopbandFrequency1'    , 1e4,'PassbandFrequency1'  ,  1e5, ...
%                     'PassbandFrequency2'    , 1e6, 'StopbandFrequency2' , 1.1e6, ...
%                     'StopbandAttenuation1'  , 60 , 'PassbandRipple'     , 0.1, ...
%                     'StopbandAttenuation2'  , 60 , 'SampleRate'         , 50000000, ...
%                     'DesignMethod', 'equiripple');
load('BandPassFilter-100K-1M.mat');
%fvtool(bpFilt);

% lpFilt = designfilt('lowpassfir','PassbandFrequency',10, ...
%          'StopbandFrequency',20,'PassbandRipple',0.1, ...
%          'StopbandAttenuation',50,'SampleRate',5000);
     
%fvtool(lpFilt);

%hpFilt = designfilt('highpassfir','PassbandFrequency',50, ...
%         'StopbandFrequency',40,'PassbandRipple',0.1, ...
%         'StopbandAttenuation',100,'SampleRate',5000);
%fvtool(hpFilt);

%bsFilt = designfilt('bandstopfir','FilterOrder',500, ...
%         'CutoffFrequency1',130,'CutoffFrequency2',160, ...
%         'SampleRate',5000);
%fvtool(bsFilt);

%www = filter(bsFilt,W')';
%www = filter(lpFilt,W')';
%www = filter(hpFilt,W')';
www = filter(bpFilt,W')';

%wfft(www(1,:),SR);
%hold off;
