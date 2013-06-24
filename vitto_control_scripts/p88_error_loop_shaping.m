% calculate_error_loop_shaping.m
% Applies steady-state performance characteristics to model
% Calculates respective errors
% Requires finished controller


% Steady state gain of Gp_nominal
Kp=dcgain(Gp_nominal*s^sys_p); 


%% Find beta
if sys_h==0
    beta=1;
end
if sys_h > 0
    beta=0;
end


%% Find steady state error due to polynomial reference input
if dr_h==0
    if sys_h==0
        dr_error= Kd^2*dr_coeff/(Kd*beta + Kp*Kc*Ga);
    end
    if sys_h==1
        dr_error=0;
    end
    if sys_h==2
        dr_error=0;
    end
end

if dr_h==1
    if sys_h==0
        dr_error= inf;
    end
    if sys_h==1
        dr_error=Kd^2*dr_coeff/(Kp*Kc*Ga);
    end
    if sys_h==2
        dr_error=0;
    end
end

if dr_h==2
    if sys_h==0
        dr_error= inf;
    end
    if sys_h==1
        dr_error=inf;
    end
    if sys_h==2
        dr_error=Kd^2*dr_coeff/(Kp*Kc*Ga);
    end
end

%% Find steady state error due to disturbance dp

% If there is no plant disturbance error is null.
if dp_type==0
    dp_error=0;
end

% Calculate dp_error if dp is a polynomial input
if dp_type==1
    if sys_h > dp_h
        dp_error=0;
    end
    if sys_h==dp_h
         dp_error=dp_coeff/(beta+Kc*Kp*Ga*Gf*Gs);
    end
end




%% Find steady state error due to disturbance da
if da_type==0
    da_error=0;
end

if da_type==1
    da_error=da_error_max/(da_coeff*Kp);
end


   