% hinf1_chose_weighting_functions.m
% Chose Weighting function W1 and W2
% Requires Ws, Wu, and Wt filters

%% Get W1

% if W1 has mu+p poles in the origin, it is unstable.
% % They must be moved by 0.01 from origin
% W1.tf.value=derp^-1; % SELECT PASSTHROUGH MODE
W1.tf.value=Ws.tf.value;
W1.tf.inv=W1.tf.value^-1;   

%% Modify W1
% For polynomial or null plant disturbance
if (dp.values.type == 0 || dp.values.type == 1) && (da.values.type == 0 || da.values.type == 1)
    W1.mod.value=W1.tf.value * (s)^(sys.mu + sys.p)/(s+Wc.design.value*10^-6)^(sys.mu + sys.p); % Replace origin poles with poles close to origin for simulink
end

% For sinusoidal plant disturbance
if da.values.type == 2
    W1.mod.value=W1.tf.value*s^(sys.mu + sys.p)/(s + da.values.frequency*10^-5)^(sys.mu + sys.p);
end

if dp.values.type == 2
    W1.mod.value=W1.tf.value*s^(sys.mu + sys.p)/(s + dp.values.frequency*10^-5)^(sys.mu + sys.p);
end

% minreal
W1.mod.value=minreal(  W1.mod.value);

% create different representations
W1.mod.inv=W1.mod.value^-1;

[W1.tf.num,W1.tf.den]=tfdata(W1.tf.value,'v');
[W1.mod.num,W1.mod.den]=tfdata(W1.mod.value,'v');

W1.tf.zpk=zpk(W1.tf.value);
W1.mod.zpk=zpk(W1.mod.value);




%% debug prints
% figure
% hold on
% bode(tf(S.design.p.value),tf(Ms_lf.value),S.design.value,W1.tf.inv,W1.mod.inv,logspace(-5,5))
% legend ('Sp','Ms','S','W1inv','W1modinv')
% hold off


%% GET W2 - AUTO (FAIL)

% plot Wt, and plot Wu. Make higher curve equal to W2.
% bode(Wt.tf.value,Wu.multiplicative.tf.value); % PICK HIGHER OF TWO CURVES

% Automatic procedure (not useful because of unstable zeros)
% % convenient when there is no clear winner between Wu and Wt
%      W2 = createmaxtf(tf(1/Tp), Wu, vector_log, 4, 0); % Doesn't work because LMI optimization fails
%     W2 = createmaxtf(Wt, Wu, vector_log, 4, 1); % Doesn't work because system is improper
%     W2_zpk = zpk(W2);
%     W2mod=W2;

%% GET W2 - Manual procedure
% % convienent when there is a clear higher curve
% % If you pick Wt, We use Tp instead of Wt to remove unstable zeros
W2.tf.value=Wt.tf.value; % Doesn't work due to unstable zeros
W2.mod.value=tf(1/T.design.p.value); % Same as Wt without zeros

% % If you pick Wu
% W2=Wu; % pick highest value of Wu
% W2mod=tf(dcgain(Wu))



%% Get tf numerator and denominator
[ W2.tf.num, W2.tf.den]=tfdata(W2.tf.value, 'v');
[ W2.mod.num, W2.mod.den]=tfdata(W2.mod.value, 'v');

W2.tf.zpk=zpk(W2.tf.value);
W2.mod.zpk=zpk(W2.tf.value);
