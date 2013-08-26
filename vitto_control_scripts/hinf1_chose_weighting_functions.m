% hinf1_chose_weighting_functions.m
% Chose Weighting function W1 and W2
% Requires Ws, Wu, and Wt filters

%% GET W1

% if W1 has mu+p poles in the origin, it is unstable.
% % They must be moved by 0.01 from origin


% For polynomial or null plant disturbance
if dp.type == 0 || dp.type == 1
    W1.tf.value=Ws.tf.value;
    W1.mod.value=W1.tf.value * s^sys.h/(s+.01)^sys.h; % Replace origin poles with poles close to origin
    W1.mod.value=minreal(W1.mod.value);
end

% For sinusoidal plant disturbance
if dp.type==2
    W1.tf.value=Ws.tf.value;
    W1.mod.value=W1.tf.value;
end

[W1.tf.num,W1.tf.den]=tfdata(W1.tf.value,'v');
[W1.mod.num,W1.mod.den]=tfdata(W1.mod.value,'v');


%% GET W2 - AUTO (FAIL)

% plot Wt, and plot Wu. Make higher curve equal to W2.
% bode(Wt,Wu); % PICK HIGHER OF TWO CURVES

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
[ W2.tf.num W2.tf.den]=tfdata(W2.tf.value, 'v');
[ W2.mod.num W2.mod.den]=tfdata(W2.mod.value, 'v');

