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
[r.mu r.calculatedError r.errorFunctionString] = ...
findminimumcontrollerorder(r.errorString, Gp.nominal.tf, Ga, Gf, Gs, r.maxError);



%% For Actuator input
[da.mu da.calculatedError da.errorFunctionString] = ...
findminimumcontrollerorder(da.errorString, Gp.nominal.tf, Ga, Gf, Gs, da.maxError);

%% For Plant input
[dp.mu dp.calculatedError dp.errorFunctionString] = ...
findminimumcontrollerorder(dp.errorString, Gp.nominal.tf,  Ga, Gf, Gs, dp.maxError);

%% For Sensor input
[ds.mu ds.calculatedError ds.errorFunctionString] = ...
findminimumcontrollerorder(ds.errorString, Gp.nominal.tf, Ga, Gf, Gs, ds.maxError);

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


