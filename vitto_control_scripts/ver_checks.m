% ver_checks.m
% contains various checks to assure proper functionality of control system


%% Check error values

% Error tolerances
dr_error_max % Max output error due to reference input
dr_error % output error due to reference input
da_error_max % Max output error in presence of da
da_error % output error in presence of da
dp_error_max % Max output error in presence of dp
dp_error % output error in presence of dp
ds_error_max % Max output error in presence of ds
ds_error % output error in presence of ds



% TP AND SP ARE FILTER RIPPLE VALUES????????????
% 
% %% TEST
% Rs=10
% Rp=Tp_db
% Ws=2800
% Wp=2000
% [n,Wn]=buttord(Wp,Ws,Rp,Rs,'s') 
% [z, p, k] = butter(n,Wn,'s');
% 
% testfilt=zpk(z,p,k)