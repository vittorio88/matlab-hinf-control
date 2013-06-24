% hinf3_error_sim.m
% Simulates error functions and captures values
% Requires finished controller


%% following must always be initialized to one for simulink
dr_on=1;
da_on=1;
dp_on=1;
ds_on=1;
u = [dr_on,da_on,dp_on,ds_on];
t = 0; % should be 0



%% Find Rise Time, Settling Time, and overshoot

% if dr_h==0
% dr_on=1;
% da_on=1;
% dp_on=1;
% ds_on=1;
% u = [dr_on,da_on,dp_on,ds_on];
% [simulink_gry_time,simulink_gry]=sim('system_model');
% time_info = stepinfo(logsout.y.data,tout,5,'RiseTimeLimits',[0.05,0.95])
% end

% Find error functions



%% get ery
dr_on=1;
da_on=0;
dp_on=0;
ds_on=0;
u = [dr_on,da_on,dp_on,ds_on];
[simulink_ery_time,simulink_ery_states,simulink_ery_out]=sim('system_model');

%% get eay
dr_on=0;
da_on=1;
dp_on=0;
ds_on=0;
u = [dr_on,da_on,dp_on,ds_on];
[simulink_eay_time,simulink_eay_states,simulink_eay_out]=sim('system_model');

%% get epy
dr_on=0;
da_on=0;
dp_on=1;
ds_on=0;
u = [dr_on,da_on,dp_on,ds_on];
[simulink_epy_time,simulink_epy_states,simulink_epy_out]=sim('system_model');

%% get esy
dr_on=0;
da_on=0;
dp_on=0;
ds_on=1;
u = [dr_on,da_on,dp_on,ds_on];
[simulink_esy_time,simulink_esy_states,simulink_esy_out]=sim('system_model');

%% reset switches to 1
dr_on=1;
da_on=1;
dp_on=1;
ds_on=1;
u = [dr_on,da_on,dp_on,ds_on];


