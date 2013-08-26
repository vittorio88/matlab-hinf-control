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
if r.type==1
    r.mu = findminimumcontrollerorder(r.maxError, r.order, sys.p);
end

% For Actuator input
if da.type==1
    da.mu = findminimumcontrollerorder(da.maxError, da.order, sys.p);
end

% For Plant input
if dp.type==1
    dp.mu = findminimumcontrollerorder(dp.maxError, dp.order, sys.p);
end

% For Sensor input
if ds.type==1
    ds.mu = findminimumcontrollerorder(ds.maxError, ds.order, sys.p);
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

% reference input
r_othersignal=r.coefficient*(1/s^(r.order));


