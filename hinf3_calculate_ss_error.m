% hinf3_calculate_ss_error.m
% Calculates respective errors
% Requires finished controller



%% Find steady state error due to polynomial reference input
r.errors.nominal=dcgain(s*Kd*S.nominal.value*r.signal*r.values.tf);

% CORRECTION, TEST ME
%r.errors.nominal=dcgain(s*s^(sys.mu + sys.p)*Kd*S.nominal.value*r.signal*r.values.tf);


%% Find steady state error due to disturbance da

da.errors.nominal = dcgain(s*T.nominal.value * 1/(Ga*Gc.mod.value*Gf*Gs) *da.signal * da.values.tf);

% % OLD PROBABLY WORKS
% % If da is null, da error is null
% if da.type==0
%     da.actualError=0;
% end
%
%
% % Calculate da_error if da is a polynomial input
% if da.type==1
%     if   (da.mu + sys.p) < sys.h
%         da.actualError=0;
%     end
%     if (da.mu + sys.p) == sys.h
%        da.actualError= da.coefficient*(1+dcgain(Gc.mod.value*s^sys.mu*Ga*Gf*Gs)/dcgain(Gp.nominal.tf*s^sys.p));
%     end
% end

%% Find steady state error due to disturbance dp

dp.errors.nominal = dcgain(s*S.nominal.value * dp.signal * dp.values.tf / Gs);

% % OLD PROBABLY WORKS
% % If there is no plant disturbance error is null.
% if dp.type==0
%     dp.actualError=0;
% end
%
% % Calculate dp_error if dp is a polynomial input
% if dp.type==1
%     if   (dp.mu + sys.p) < sys.h
%         dp.actualError = 0;
%     end
%     if (dp.mu + sys.p) == sys.h
%         dp.actualError = dp.coefficient * Kc*dcgain(S.nominal.star)*Kp; % POSSIBLY WRONG
%     end
% end
%
% % Calculate dp_error if dp is a sinusoidal input
% if dp.type==2
%     dp.actualError=abs(dp.coefficient*evalfr(S.nominal.star,1i*dp.frequency)); % GOOD CHECK FOR FILTER
%
% end



%% Find steady state error due to sinusoidal disturbance ds
ds.errors.nominal=dcgain(s*T.nominal.value*ds.signal*ds.values.tf);

% % OLD PROBABLY WORKS
% if ds.type==0
%     ds.actualError=0;
% end
%
% if ds.type==2
%     ds.actualError=abs(ds.coefficient*evalfr(T.nominal.value,1i*ds.frequency)/(Gs)); % GOOD CHECK FOR FILTER
%     %     ds_error=ds_coeff*Kc*dcgain(Tn)/Gs; %WRONG
% end

