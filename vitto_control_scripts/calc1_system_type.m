% find_system_type.m
% Finds system type

%% Find system type

% Initalize Values
dr_mu = 0;
da_mu = 0;
dp_mu = 0;
ds_mu = 0;

sys_p=nGp_poles;

% For reference input
if dr_type==1
    dr_mu = findminimumcontrollerorder(dr_error_max, dr_h, sys_p);
end

% For Actuator input
if da_type==1
    da_mu = findminimumcontrollerorder(da_error_max, da_h, sys_p);
end

% For Plant input
if dp_type==1
    dp_mu = findminimumcontrollerorder(dp_error_max, dp_h, sys_p);
end

% For Sensor input
if ds_type==1
    ds_mu = findminimumcontrollerorder(ds_error_max, ds_h, sys_p);
end

%% Find minimum amount of poles @ s=0 for Gc
sys_mu=max(da_mu,dp_mu);
sys_mu=max(dr_mu,sys_mu);

% Check for negatives
if dr_mu<0
    dr_mu=0;
end
if da_mu<0
    da_mu=0;
end
if dp_mu<0
    dp_mu=0;
end
if ds_mu<0
    ds_mu=0;
end
if sys_mu<0
    sys_mu=0;
end

%% Define system order and input signal

sys_h=sys_mu+sys_p;

% reference input
r=dr_coeff*(1/s^(dr_h));


