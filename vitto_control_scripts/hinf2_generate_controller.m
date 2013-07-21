% generate_hinf.m



%% Create state space model from Simulink
[Am,Bm,Cm,Dm]=linmod('plantM'); %% Get stace-space model from plantM simulink
M_simulink=ltisys(Am,Bm,Cm,Dm); %% convert state-space to SYS model M

%% add two unstable poles previously removed from Wt.
M_filtered=sderiv(M_simulink,2,[1/abs(Wt_zpk.z{1}(1)) 1 ]);
M_filtered=sderiv(M_filtered,2,[1/abs(Wt_zpk.z{1}(2)) 1 ]);

% M_min = ss(M_filtered); % minreal of SYS model after adding poles

%% Find set of solutions to matrix inequalities
% [gopt,Cmod]=hinflmi(M_filtered,[1 1]); % simple
[gopt,Cmod]=hinflmi(M_filtered,[1,1],0,1e-6,[0 0 0]); % with more args

[Ac,Bc,Cc,Dc]=ltiss(Cmod);
[Gc_num,Gc_den] = ss2tf(Ac,Bc,Cc,Dc);
Gc=tf(Gc_num,Gc_den);
Gc_zpk=zpk(Gc);

%% Modify controller if necessary
Gc_gainmod=1;

% Change low frequency poles to s^mu
Gcmod=Gc*Gc_gainmod*(s+0.01)^sys_mu/s^sys_mu; % does have poles at origin
% Gcmod = Gc_zpk*(s-Gc_zpk.p{1}(2))*(s-Gc_zpk.p{1}(3))/(s+abs(Gc_zpk.p{1}(2))) / (s+abs(Gc_zpk.p{1}(3)))
% Gcmod=minreal(Gcmod,1e-4)

% Gcmod=Gcmod*(s+9.859)^sys_mu/s^sys_mu % does have poles at origin

% Gcmod=Gc*Gc_gainmod; % doesnt have poles at origin
Gcmod=minreal(Gcmod,1e-4)


% Gcmod=(0.4353*s^3 + 240.0*s^2 + 11222.0*s + 687.9)/(s^3 + 7218.0*s^2 + 141990.0*s + 698550.0)


%% Generate complementary functions

% Generate nominal loop and sensitivity functions
Ln=Gcmod*Ga*Gp_nominal*Gs*Gf;
Tn=Ln/(1+Ln);
Sn=1-Tn;

% Calculate controller DC gain
Kc=dcgain((s^sys_mu)*Gcmod);

Sn_star=Sn/s^(sys_h); % Remove poles and zeros at s=0
Sn_star=minreal(Sn_star);% Cancel poles and zeros at s=0

