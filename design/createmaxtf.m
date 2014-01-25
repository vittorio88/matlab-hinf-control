function [ maxTf ] = createmaxtf( tf1, tf2, vector_log, orderFit, removeStabilization )
%createmaxtf Get values for a max tf, maximize, curve-fit, and convert
%into a new tf

tf1_mag = bode(tf1,vector_log);
tf2_mag = bode(tf2,vector_log);
%  tf1_mag = squeeze(tf1_mag);
%  tf2_mag = squeeze(tf2_mag);


maxTf_discrete=[length(vector_log),1];
for iFreq=1 : 1 : length(vector_log);
    maxTf_discrete(iFreq) = max(tf1_mag(iFreq),tf2_mag(iFreq));
end

% Fit model to discrete frequencies to ZPK
maxTf_packed=vpck(maxTf_discrete' , vector_log');
maxTf_fitted=fitsys(maxTf_packed, orderFit, [], 0); % 4th order
[maxTf_A, maxTf_B, maxTf_C, maxTf_D]=unpck(maxTf_fitted);
[maxTf_Z, maxTf_P, maxTf_K]=ss2zp(maxTf_A, maxTf_B, maxTf_C, maxTf_D);

if removeStabilization == 1
    % % find position of pole and equivalent zpk
    badPoles=[maxTf_P(1), maxTf_P(2)]; % Pick badpole (first 2 poles because poles are in order of descending frequency)
    maxTf_badPole= zpk( [], badPoles,1); % zpk of pole to remove
    
    % Cancel high freq pole, and adjust gain
    maxTf_P(1)=[];
    maxTf_P(1)=[];
    maxTf_K = dcgain(maxTf_badPole)*maxTf_K;
end

% convert zpk to tf
maxTf_zpk=zpk(maxTf_Z, maxTf_P, maxTf_K);
[maxTf_num , maxTf_den] = tfdata(maxTf_zpk, 'v');
maxTf = tf( maxTf_num , maxTf_den );


end

