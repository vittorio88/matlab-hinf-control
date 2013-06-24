% generate_hinf.m



%% GET W1

% if W1 has mu+p poles in the origin, it is unstable.
% % They must be moved by 0.01 from origin

if dp_type == 0 || dp_type == 1
W1=Ws;
W1mod=W1 * s^sys_h/(s+.01)^sys_h; % Replace origin poles with poles close to origin
W1mod=minreal(W1mod);
end

if dp_type==2
    W1=Ws;
    W1mod=W1;
end

[W1_num,W1_den]=tfdata(W1,'v');
[W1mod_num,W1mod_den]=tfdata(W1mod,'v');


%% GET W2 Automatic (not useful because of unstable zeros)
% % W2 should be highest for each w of Wt and Wu
% %  bode(Wt,Wu); % PICK HIGHER OF TWO CURVES
% 
% [Wt_mag, Wt_phase] = bode(Wt,vector_log);
% [Wu_mag, Wu_phase] = bode(Wu,vector_log);
% %  Wt_mag = squeeze(Wt_mag);
% %  Wu_mag = squeeze(Wu_mag);
% 
% 
% W2_discrete=[vector_log_slices,1];
% for sfreq=1 : 1 : vector_log_slices;
%     W2_discrete(sfreq) = max(Wt_mag(sfreq),Wu_mag(sfreq));
% end
% 
% % Fit model to discrete frequencies to ZPK
% W2_packed=vpck(W2_discrete' , vector_log');
% W2_fitted=fitsys(W2_packed,4,[],0); % 2nd order, code 1 = rational fit
% [Aw2,Bw2,Cw2,Dw2]=unpck(W2_fitted);
% [Zw2,Pw2,Kw2]=ss2zp(Aw2,Bw2,Cw2,Dw2);
% 
% 
% % % find position of pole and equivalent zpk
% P_badpole=[Pw2(1),Pw2(2)]; % Pick badpole (first 2 poles because poles are in order of descending frequency)
% W2_badpole= zpk( [], P_badpole,1); % zpk of pole to remove
% 
% % Cancel high freq pole, and adjust gain
%  Pw2(1)=[];
%  Pw2(1)=[];
% Kw2=dcgain(W2_badpole)*Kw2;
% 
% 
% % convert zpk to tf
% W2_zpk=zpk(Zw2,Pw2,Kw2);
% [W2_num , W2_den] = tfdata(W2_zpk, 'v');
% W2 = tf( W2_num , W2_den );
% 
% % Verify
% % bode(Wt,Wu,W2)
% 
% 
% 
% %% GET W2mod Automatic (no unstable zeros)
% % %    W2 should be highest for each w of Wt and Wu
%  bode(tf(1/Tp),Wu);% PICK HIGHER OF TWO CURVES
%  
% [Wt_mag, Wt_phase] = bode(tf(1/Tp),vector_log);
% [Wu_mag, Wu_phase] = bode(Wu,vector_log);
% %  Wt_mag = squeeze(Wt_mag);
% %  Wu_mag = squeeze(Wu_mag);
% 
% 
% W2mod_discrete=[vector_log_slices,1];
% for sfreq=1 : 1 : vector_log_slices;
%     W2mod_discrete(sfreq) = max(Wt_mag(sfreq),Wu_mag(sfreq));
% end
% 
% % Fit model of discrete magnitudes to ZPK
% W2mod_packed=vpck(W2mod_discrete' , vector_log');
% W2mod_fitted=fitsys(W2mod_packed,2,[],1); % 2nd order, code 1 = rational fit
% [Aw2m,Bw2m,Cw2m,Dw2m]=unpck(W2mod_fitted);
% [Zw2m,Pw2m,Kw2m]=ss2zp(Aw2m,Bw2m,Cw2m,Dw2m);
% W2mod_zpk=zpk(Zw2m,Pw2m,Kw2m);
% 
% % Generate tf
% [W2mod_num , W2mod_den] = tfdata(W2mod_zpk , 'v');
% W2mod = tf( W2mod_num , W2mod_den );
% 
% % Verify
% % bode(tf(1/Tp),Wu,W2mod)
% 

%% PICK W2 Manual procedure
% plot Wt, and plot Wu. Make lower curve equal to W2.
% bode(Wt,Wu); % PICK HIGHER OF TWO CURVES

% % If you pick Wt, We use Tp instead of Wt to remove unstable zeros
W2=Wt; % Doesn't work due to unstable zeros
W2mod=tf(1/Tp); % Same as Wt without zeros

% % If you pick Wu
% W2=Wu; % pick highest value of Wu
% W2mod=tf(dcgain(Wu))

[ W2_num W2_den]=tfdata(W2, 'v');
[ W2mod_num W2mod_den]=tfdata(W2mod, 'v');



%% Design Plant M
[Am,Bm,Cm,Dm]=linmod('plantM'); %% Get stace-space model from plantM simulink 
M_simulink=ltisys(Am,Bm,Cm,Dm); %% convert state-space to SYS model M

% add two poles at same frequency
M_filtered=sderiv(M_simulink,2,[1/abs(Wt_zpk.z{1}(1)) 1 ]);
M_filtered=sderiv(M_filtered,2,[1/abs(Wt_zpk.z{1}(2)) 1 ]);

% M_min = ss(M_filtered); %minreal
% [gopt,Cmod]=hinflmi(M_filtered,[1,1],0,1e-2,[0 0 0]);
[gopt,Cmod]=hinflmi(M_filtered,[1 1]);
[Ac,Bc,Cc,Dc]=ltiss(Cmod);
[Gc_num,Gc_den] = ss2tf(Ac,Bc,Cc,Dc);
Gc=tf(Gc_num,Gc_den);
Gc_zpk=zpk(Gc);

%% Modify controller if necessary
Gc_gainmod=1;

% Change low frequency poles to s^mu
 Gcmod=Gc*Gc_gainmod*(s+0.01)/s^sys_mu; % does have poles at origin
% Gcmod=Gc*Gc_gainmod; % doesnt have poles at origin
Gcmod=minreal(Gcmod,1e-4);


% Generate nominal loop and sensitivity functions
Ln=Gcmod*Ga*Gp_nominal*Gs*Gf;
Tn=Ln/(1+Ln);
Sn=1-Tn;

% Calculate controller DC gain
Kc=dcgain((s^sys_mu)*Gcmod);

Sn_star=Sn/s^(sys_h); % Remove poles and zeros at s=0
Sn_star=minreal(Sn_star);% Cancel poles and zeros at s=0

