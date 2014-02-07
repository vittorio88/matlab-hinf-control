% hinf3_error_sim.m
% Simulates error functions and captures values
% Requires finished controller

% use ode15s solver and 1e-3 precision

%% following must always be initialized to one for simulink
r.values.on=1;
da.values.on=1;
dp.values.on=1;
ds.values.on=1;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
t = 0; % should be 0



%% Find Rise Time, Settling Time, and overshoot

% if dr_h==0
% r.values.on=1;
% da.values.on=1;
% dp.values.on=1;
% ds.values.on=1;
% u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
% [simulink_gry_time,simulink_gry]=sim('system_model');
% time_info = stepinfo(logsout.y.data,tout,5,'RiseTimeLimits',[0.05,0.95])
% end

% Find error functions



%% get ery
r.values.on=1;
da.values.on=0;
dp.values.on=0;
ds.values.on=0;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
[simulink_ery_time,simulink_ery_states,simulink_ery_out]=sim('system_model_script_interactive');
simulink_ery_out = squeeze(simulink_ery_out);

%% get eay
r.values.on=0;
da.values.on=1;
dp.values.on=0;
ds.values.on=0;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
[simulink_eay_time,simulink_eay_states,simulink_eay_out]=sim('system_model_script_interactive');
simulink_eay_out = squeeze(simulink_eay_out);

%% get epy
r.values.on=0;
da.values.on=0;
dp.values.on=1;
ds.values.on=0;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
[simulink_epy_time,simulink_epy_states,simulink_epy_out]=sim('system_model_script_interactive');
simulink_epy_out = squeeze(simulink_epy_out);

%% get esy
r.values.on=0;
da.values.on=0;
dp.values.on=0;
ds.values.on=1;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];
[simulink_esy_time,simulink_esy_states,simulink_esy_out]=sim('system_model_script_interactive');
simulink_esy_out = squeeze(simulink_esy_out);

%% reset switches to 1
r.values.on=1;
da.values.on=1;
dp.values.on=1;
ds.values.on=1;
u = [r.values.on,da.values.on,dp.values.on,ds.values.on];


