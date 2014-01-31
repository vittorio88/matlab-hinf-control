% find_system_type.m
% Finds system type

%% Find system type

% Initalize Values
r.mu = 0;
da.mu = 0;
dp.mu = 0;
ds.mu = 0;

sys.p=Gp.nOriginPoles;

% Function prototype is as follows
% findminimumcontrollerorder(errorString, GpTf, maxError)
%% For reference input
[r.mu, r.errors.calculated, r.errorFunctionString] = ...
findminimumcontrollerorder(r.errorString, Gp.nominal.tf, Ga, Gf, Gs, r.errors.max);



%% For Actuator input
[da.mu, da.errors.calculated, da.errorFunctionString] = ...
findminimumcontrollerorder(da.errorString, Gp.nominal.tf, Ga, Gf, Gs, da.errors.max);

%% For Plant input
[dp.mu, dp.errors.calculated, dp.errorFunctionString] = ...
findminimumcontrollerorder(dp.errorString, Gp.nominal.tf,  Ga, Gf, Gs, dp.errors.max);

%% For Sensor input
[ds.mu, ds.errors.calculated, ds.errorFunctionString] = ...
findminimumcontrollerorder(ds.errorString, Gp.nominal.tf, Ga, Gf, Gs, ds.errors.max);

%% Find minimum amount of poles @ s=0 for Gc
sys.mu=max(da.mu,dp.mu);
sys.mu=max(r.mu,sys.mu);

% Check for negatives
if r.mu<0
    r.mu=0;
end
if da.mu<0
    da.mu=0;
end
if dp.mu<0
    dp.mu=0;
end
if ds.mu<0
    ds.mu=0;
end
if sys.mu<0
    sys.mu=0;
end

%% Define system order and input signal

sys.h=sys.mu+sys.p;


