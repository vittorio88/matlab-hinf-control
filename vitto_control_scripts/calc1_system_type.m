% find_system_type.m
% Finds system type

%% Find system type

% Initalize Values
r.mu = 0;
da.mu = 0;
dp.mu = 0;
ds.mu = 0;

sys.p=Gp.nOriginPoles;

% For reference input 
% Function prototype is as follows
% findminimumcontrollerorder(inputSignal, inputTf, cltfNoController)
if r.type==1
    [r.mu r.calculatedError] = findminimumcontrollerorder(r.signal, r.tf, r.maxError, r.errorSignalNoGc);
end

% For Actuator input
if da.type==1
[da.mu da.calculatedError] = findminimumcontrollerorder(da.signal, da.tf, da.maxError, da.errorSignalNoGc); 
end

% For Plant input
if dp.type==1
[dp.mu dp.calculatedError] = findminimumcontrollerorder(dp.signal, dp.tf, dp.maxError, dp.errorSignalNoGc);
end

% For Sensor input
if ds.type==1
[ds.mu ds.calculatedError] = findminimumcontrollerorder(ds.signal, ds.tf, ds.maxError, ds.errorSignalNoGc);
end

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


