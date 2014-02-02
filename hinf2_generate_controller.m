% generate_hinf.m


%% TODO ERROR NEEDS FIXING
% 
% Error using ltiss (line 28)
% SYS is not a SYSTEM matrix
% 
% Error in hinf2_generate_controller (line
% 20)
% [Ac,Bc,Cc,Dc]=ltiss(Cmod);
% 
% Error in a0_executor (line 18)
% hinf2_generate_controller % Generates
% hinf controller



%% Create state space model from Simulink
[Am,Bm,Cm,Dm]=linmod('generalized_plant_M'); %% Get stace-space model from plantM simulink
M_simulink=ltisys(Am,Bm,Cm,Dm); %% convert state-space to SYS model M

% Interesting to view simulink output
myss=ss(Am,Bm,Cm,Dm); 
bode(myss)


%% add two unstable poles previously removed from Wt.
% always need 2 pole removales because Wt has 2 poles
M_filtered=sderiv(M_simulink,2,[1/abs(Wt.zpk.value.z{1}(1)) 1 ]);
M_filtered=sderiv(M_filtered,2,[1/abs(Wt.zpk.value.z{1}(2)) 1 ]);

% M_min = ss(M_filtered); % minreal of SYS model after adding poles

%% Find set of solutions to matrix inequalities
% [gopt,Cmod]=hinflmi(M_filtered,[1 1]); % simple
[gopt,Cmod]=hinflmi(M_filtered,[1,1],0,1e-6,[0 0 0]); % with more args

[Ac,Bc,Cc,Dc]=ltiss(Cmod);
[Gc.tf.num,Gc.tf.den] = ss2tf(Ac,Bc,Cc,Dc);
Gc.tf.value=tf(Gc.tf.num,Gc.tf.den);
Gc.zpk.value=zpk(Gc.tf.value);

%% Modify controller if necessary
Gc.gainmod=1;

% Change low frequency poles to s^mu
Gc.mod.value=Gc.tf.value*Gc.gainmod*(s+0.01)^sys.mu/s^sys.mu; % does have poles at origin
% Gcmod = Gc_zpk*(s-Gc_zpk.p{1}(2))*(s-Gc_zpk.p{1}(3))/(s+abs(Gc_zpk.p{1}(2))) / (s+abs(Gc_zpk.p{1}(3)))
% Gcmod=minreal(Gcmod,1e-4)

% Gcmod=Gcmod*(s+9.859)^sys_mu/s^sys_mu % does have poles at origin

% Gcmod=Gc*Gc_gainmod; % doesnt have poles at origin
Gc.mod.value=minreal(Gc.mod.value,1e-4);
Gc.mod.zpk=zpk(Gc.mod.value);

% Gcmod=(0.4353*s^3 + 240.0*s^2 + 11222.0*s + 687.9)/(s^3 + 7218.0*s^2 + 141990.0*s + 698550.0)


%% Generate complementary functions

% Generate nominal loop and sensitivity functions
L.nominal.value=Gc.mod.value*Ga*Gp.nominal.tf*Gs*Gf;
T.nominal.value=L.nominal.value/(1+L.nominal.value);
S.nominal.value=1-T.nominal.value;

% Calculate controller DC gain
Kc=dcgain((s^sys.mu)*Gc.mod.value);

S.nominal.star=S.nominal.value/s^(sys.h); % Remove poles and zeros at s=0
S.nominal.star=minreal(S.nominal.star);% Cancel poles and zeros at s=0

