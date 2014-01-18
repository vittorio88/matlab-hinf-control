% translate_time_spec.m
% Calculates time-domain performance characteristics
% Requires only data_input.m

%% Calculates overshoot constraints

if overshoot.on==1
    % Calculates minimum damping coefficient
    dampingCoefficient=(abs(log(overshoot.maxValue)))/sqrt(pi^2+(log(overshoot.maxValue))^2);
end
%% Calculates rise time constraints

if riseTime.on==1
    
    % Calculate Wn from rise_time and coeff_damp
    riseTime.Wn=1/(riseTime.maxValue*sqrt(1-dampingCoefficient^2))*(pi-acos(dampingCoefficient));
    % Calculate Wc from Wn and coeff_damp
    riseTime.Wc=riseTime.Wn*sqrt( sqrt(1+4*dampingCoefficient^4) - 2*dampingCoefficient^2);
    
end
%% Calculates settling time constraints

if settlingTime.on==1
    
    %Calculate Wn from settling_time, settling_time_tolerance, and coeff_damp
    settlingTime.Wn=-log(settlingTime.tolerance)/(settlingTime.maxValue*dampingCoefficient);
    %Calculate Wc from settling_time_Wn and coeff_damp
    settlingTime.Wc=settlingTime.Wn*sqrt( sqrt(1+4*dampingCoefficient^4) - 2*dampingCoefficient^2);
    
end


%% Pick values of Wc and Wn

% Pick larger crossover frequency
Wc.min = riseTime.Wc;
if settlingTime.on==1
    Wc.min=max(riseTime.Wc, settlingTime.Wc);
end



% Get corresponding Wn from chosen Wc
if Wc.min==riseTime.Wc
    Wn.min=riseTime.Wn;
end

% Get corresponding Wn from chosen Wc
if settlingTime.on==1
    if Wc.min==settlingTime.Wc
        Wn.min=settlingTime.Wn;
    end
end

%% Set Wc and Wn

% Wc and Wn should be at least equal to Wcmin and Wnmin calculated using
% rise time, settling time, and overshoot.
% Wc=Wcmin;
% Wn=Wnmin;

Wc.design.value=700 % Highest point at which Wt has no influence (use 'bode(Wt)' to estimate)
% REMEMBER TO VIEW crossover frequency bode(L.nominal.value)

Wn.design.value=Wc.design.value/sqrt( sqrt(1+4*dampingCoefficient^4) - 2*dampingCoefficient^2);
Wb.design.value=Wn.design.value*sqrt(1-2*dampingCoefficient^2+sqrt(2-4*dampingCoefficient^2+4*dampingCoefficient^4));





%% Calculate Sensitivity function, complementary sensitivity function, and
%% Desired Loop function
T.design.value=1/(1+2*dampingCoefficient*s/Wn.design.value+(s^2)/(Wn.design.value^2)); % Complimentary sensitivity function
S.design.value=1-T.design.value; % Sensitivity Function
L.design.value=T.design.value/(1-T.design.value); % Loop function


%% Calculate bandwidth of sensitivity function and S*
S.design.bandwidth=Wn.design.value*sqrt(1-2*dampingCoefficient^2+sqrt(2-4*dampingCoefficient^2+4*dampingCoefficient^4));
S.design.star.value=S.design.value/s^(sys.h);
S.design.star.value=minreal(S.design.star.value);
S.design.star.dcgain=dcgain(S.design.star.value);

%% Calculates sensitivity and complementary sensitivity function peaks
T.design.p.value=1/(2*dampingCoefficient*sqrt(1-dampingCoefficient^2));
S.design.p.value=2*dampingCoefficient*sqrt(2+4*dampingCoefficient^2+2*sqrt(1+8*dampingCoefficient^2))/(sqrt(1+8*dampingCoefficient^2)+4*dampingCoefficient^2-1);

T.design.p.db=20*log10(T.design.p.value);
S.design.p.db=20*log10(S.design.p.value);
