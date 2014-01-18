% hinf3_error_sim.m
% Simulates error functions and captures values
% Requires finished controller

% use ode15s solver and 1e-3 precision

%% following must always be initialized to one for simulink
r.on=1;
da.on=1;
dp.on=1;
ds.on=1;
u = [r.on,da.on,dp.on,ds.on];
t = 0; % should be 0



%% Find Rise Time, Settling Time, and overshoot

% if dr_h==0
% r.on=1;
% da.on=1;
% dp.on=1;
% ds.on=1;
% u = [r.on,da.on,dp.on,ds.on];
% [simulink_gry_time,simulink_gry]=sim('system_model');
% time_info = stepinfo(logsout.y.data,tout,5,'RiseTimeLimits',[0.05,0.95])
% end

% Find error functions



%% get ery
r.on=1;
da.on=0;
dp.on=0;
ds.on=0;
u = [r.on,da.on,dp.on,ds.on];
[simulink_ery_time,simulink_ery_states,simulink_ery_out]=sim('system_model_script_interactive');

%% get eay
r.on=0;
da.on=1;
dp.on=0;
ds.on=0;
u = [r.on,da.on,dp.on,ds.on];
[simulink_eay_time,simulink_eay_states,simulink_eay_out]=sim('system_model_script_interactive');

%% get epy
r.on=0;
da.on=0;
dp.on=1;
ds.on=0;
u = [r.on,da.on,dp.on,ds.on];
[simulink_epy_time,simulink_epy_states,simulink_epy_out]=sim('system_model_script_interactive');

%% get esy
r.on=0;
da.on=0;
dp.on=0;
ds.on=1;
u = [r.on,da.on,dp.on,ds.on];
[simulink_esy_time,simulink_esy_states,simulink_esy_out]=sim('system_model_script_interactive');

%% reset switches to 1
r.on=1;
da.on=1;
dp.on=1;
ds.on=1;
u = [r.on,da.on,dp.on,ds.on];


