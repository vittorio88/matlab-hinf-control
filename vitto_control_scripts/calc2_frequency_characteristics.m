% translate_time_spec.m
% Calculates time-domain performance characteristics
% Requires only data_input.m

%% Calculates overshoot constraints

if overshoot_on==1
    % Calculates minimum damping coefficient
    coeff_damp=(abs(log(overshoot)))/sqrt(pi^2+(log(overshoot))^2);
end
%% Calculates rise time constraints

if rise_time_on==1
    
    % Calculate Wn from rise_time and coeff_damp
    rise_time_Wn=1/(rise_time*sqrt(1-coeff_damp^2))*(pi-acos(coeff_damp));
    % Calculate Wc from Wn and coeff_damp
    rise_time_Wc=rise_time_Wn*sqrt( sqrt(1+4*coeff_damp^4) - 2*coeff_damp^2);
    
end
%% Calculates settling time constraints

if settling_time_on==1
    
    %Calculate Wn from settling_time, settling_time_tolerance, and coeff_damp
    settling_time_Wn=-log(settling_time_tolerance)/(settling_time*coeff_damp);
    %Calculate Wc from settling_time_Wn and coeff_damp
    settling_time_Wc=settling_time_Wn*sqrt( sqrt(1+4*coeff_damp^4) - 2*coeff_damp^2);
    
end


%% Pick values of Wc and Wn

% Pick larger crossover frequency
Wcmin = rise_time_Wc;
if settling_time_on==1
    Wcmin=max(rise_time_Wc, settling_time_Wc);
end



% Get corresponding Wn from chosen Wc
if Wcmin==rise_time_Wc
    Wnmin=rise_time_Wn;
end

% Get corresponding Wn from chosen Wc
if settling_time_on==1
    if Wcmin==settling_time_Wc
        Wnmin=settling_time_Wn;
    end
end

%% Set Wc and Wn

% Wc and Wn should be at least equal to Wcmin and Wnmin calculated using
% rise time, settling time, and overshoot.
% Wc=Wcmin;
% Wn=Wnmin;

Wc=700 % Highest point at which Wt has no influence (use 'bode(Wt)' to estimate)
Wn=Wc/sqrt( sqrt(1+4*coeff_damp^4) - 2*coeff_damp^2)
Wb=Wn*sqrt(1-2*coeff_damp^2+sqrt(2-4*coeff_damp^2+4*coeff_damp^4))





%% Calculate Sensitivity function, complementary sensitivity function, and
%% Desired Loop function
T=1/(1+2*coeff_damp*s/Wn+(s^2)/(Wn^2)); % Complimentary sensitivity function
S=1-T; % Sensitivity Function
L=T/(1-T); % Loop function


%% Calculate bandwidth of sensitivity function
S_bandwidth=Wn*sqrt(1-2*coeff_damp^2+sqrt(2-4*coeff_damp^2+4*coeff_damp^4));
S_star=S/s^(sys_h);
S_star=minreal(S_star);

%% Calculates sensitivity and complementary sensitivity function peaks
Tp=1/(2*coeff_damp*sqrt(1-coeff_damp^2));
Sp=2*coeff_damp*sqrt(2+4*coeff_damp^2+2*sqrt(1+8*coeff_damp^2))/(sqrt(1+8*coeff_damp^2)+4*coeff_damp^2-1);

Tp_db=20*log10(Tp);
Sp_db=20*log10(Sp);
