% hinf3_calculate_ss_error.m
% Calculates respective errors
% Requires finished controller



%% Find steady state error due to polynomial reference input
if (dr_mu + sys_p) < sys_h
    dr_error=0;
end

if (dr_mu + sys_p) == sys_h
    dr_error=dcgain(Sn_star) * Kd * dr_coeff;
end

%% Find steady state error due to disturbance dp

% If there is no plant disturbance error is null.
if dp_type==0
    dp_error=0;
end

% Calculate dp_error if dp is a polynomial input
if dp_type==1
    if   (dp_mu + sys_p) < sys_h
        dp_error = 0;
    end
    if (dp_mu + sys_p) == sys_h
        dp_error = dp_coeff * Kc*dcgain(Sn_star)*Kp; % POSSIBLY WRONG
    end
end

% Calculate dp_error if dp is a sinusoidal input
if dp_type==2
    %     dp_error = dp_coeff * Kc*dcgain(Sn_star)*Kp;%WRONG
    dp_error=abs(dp_coeff*evalfr(Sn,1i*dp_freq));
end



%% Find steady state error due to disturbance da

% If da is null, da error is null
if da_type==0
    da_error=0;
end


% Calculate da_error if da is a polynomial input
if da_type==1
    if   (da_mu + sys_p) < sys_h
        da_error=0;
    end
    if (da_mu + sys_p) == sys_h
        %         da_error=dp_coeff*dcgain(Sn_star); % POSSIBLY WRONG
        da_error=dcgain(s*da_coeff*Gp_nominal/(1+Ln)); % POSSIBLY WRONG
    end
end

%% Find steady state error due to sinusoidal disturbance ds
if ds_type==0
    ds_error=0;
end

if ds_type==2
    ds_error=abs(ds_coeff*evalfr(Tn,1i*ds_freq)/(Gs));
    %     ds_error=ds_coeff*Kc*dcgain(Tn)/Gs; %WRONG
end

