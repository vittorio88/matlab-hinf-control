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
% Wc=Wc.min;
% Wn=Wn.min;

Wc.design.value=Wc.min; % Highest point at which Wt has no influence (use 'bode(Wt)' to estimate)
% REMEMBER TO VIEW crossover frequency 'bode(L.nominal.value)'

Wn.design.value=Wc.design.value/sqrt( sqrt(1 + 4*dampingCoefficient^4) - 2*dampingCoefficient^2);
Wb.design.value=Wn.design.value*sqrt(1 - 2*dampingCoefficient^2 + sqrt(2 - 4*dampingCoefficient^2+4*dampingCoefficient^4));



%% Calculate Sensitivity function, complementary sensitivity function, and
%% Desired Loop function
T.design.value=1/(1+2*dampingCoefficient*s/Wn.design.value+(s^2)/(Wn.design.value^2)); % Complimentary sensitivity function
S.design.value=1-T.design.value; % Sensitivity Function

% Increase Wn until S.design clears low frequency disturbance attenuation
% value
if da.values.type == 2
    while(abs(evalfr(S.design.value,1i* da.values.frequency)) > Ms_lf.value)
        Wn.design.value = Wn.design.value + 1;
        T.design.value=1/(1+2*dampingCoefficient*s/Wn.design.value+(s^2)/(Wn.design.value^2)); % Complimentary sensitivity function
        S.design.value=1-T.design.value; % Sensitivity Function
    end
    Wc.design.value=Wn.design.value*sqrt( sqrt(1 + 4*dampingCoefficient^4) - 2*dampingCoefficient^2);
    Wb.design.value=Wn.design.value*sqrt(1 - 2*dampingCoefficient^2 + sqrt(2 - 4*dampingCoefficient^2+4*dampingCoefficient^4));
end

if dp.values.type == 2
    while(abs(evalfr(S.design.value,1i* dp.values.frequency)) > Ms_lf.value)
        Wn.design.value = Wn.design.value + 1;
        T.design.value=1/(1+2*dampingCoefficient*s/Wn.design.value+(s^2)/(Wn.design.value^2)); % Complimentary sensitivity function
        S.design.value=1-T.design.value; % Sensitivity Function
    end
    Wc.design.value=Wn.design.value*sqrt( sqrt(1 + 4*dampingCoefficient^4) - 2*dampingCoefficient^2);
    Wb.design.value=Wn.design.value*sqrt(1 - 2*dampingCoefficient^2 + sqrt(2 - 4*dampingCoefficient^2+4*dampingCoefficient^4));
end


L.design.value=T.design.value/(1-T.design.value); % Loop function


%% Calculate bandwidth of sensitivity function and S*
S.design.bandwidth=Wn.design.value*sqrt(1-2*dampingCoefficient^2+sqrt(2-4*dampingCoefficient^2+4*dampingCoefficient^4));
S.design.dcgain = dcgain(S.design.value/s);
S.star.upperLimit = S.design.dcgain;

%% Calculates sensitivity and complementary sensitivity function peaks
T.design.p.value=1/(2*dampingCoefficient*sqrt(1-dampingCoefficient^2));
S.design.p.value=2*dampingCoefficient*sqrt(2+4*dampingCoefficient^2+2*sqrt(1+8*dampingCoefficient^2))/(sqrt(1+8*dampingCoefficient^2)+4*dampingCoefficient^2-1);

T.design.p.db=20*log10(T.design.p.value);
S.design.p.db=20*log10(S.design.p.value);



%% Calculate constraints on S*(0) from specifications

% set S*(0) lower limit to most restrictive constraint from polynomial
% inputs
if r.values.type == 1
    r.constraints.Sstar = r.errors.max / ( Kd * r.values.coefficient);
    S.star.lowerLimit = r.constraints.Sstar;
end
if da.values.type == 1
    da.constraints.Sstar = da.errors.max / (da.values.coefficient * abs(Kp) ) ;
    S.star.lowerLimit=max(S.star.lowerLimit, da.constraints.Sstar );
end
if dp.values.type == 1
    dp.constraints.Sstar = dp.errors.max / dp.values.coefficient ;
    S.star.lowerLimit=max(S.star.lowerLimit, dp.constraints.Sstar );
end

% chose effective dcgain of S
% S.star.dcgain = (S.star.upperLimit + S.star.lowerLimit) / 2;
S.star.dcgain =S.star.lowerLimit;
S.star.value = S.star.dcgain * s^(sys.mu + sys.p);


% %% Calculate steady state error for functions that have mu + p = h
%  WRONG AND WORTHLESS
% if r.values.type == 1
% r.errors.design = dcgain(s*Kd*S.design.value*r.signal*r.values.tf);
%     if r.errors.design > r.errors.max
%         warning('r design steady state error does not satisfy spec.')
%     end
% end
%
% if da.values.type == 1
%     % both are correct
%     da.errors.design = dcgain(s*T.design.value * 1/(Ga*Gf*Gs) *da.signal * da.values.tf);
% %     da.errors.design =  dcgain(da.values.coefficient* Kp/(1+Kp*Ga*Gf*Gs));
%     if da.errors.design > da.errors.max
%         warning('da design steady state error does not satisfy spec.')
%     end
% end
%
%
% if dp.values.type == 1
% dp.errors.design =dcgain(s*S.design.value * dp.signal * dp.values.tf / Gs);
%     if dp.errors.design > dp.errors.max
%         warning('dp design steady state error does not satisfy spec.')
%     end
% end


%% check Wc
if Wc.design.value < Wc.min
    warning( 'Wc is too low to satisfy rising time or settling time constraint');
end

if da.values.type == 2
    if Wc.design.value < da.values.frequency
        warning( 'Wc is too low');
    end
end

if dp.values.type == 2
    if Wc.design.value < dp.values.frequency
        warning( 'Wc is too low');
    end
end

if ds.values.type == 2
    if Wc.design.value > ds.values.frequency
        warning( 'Wc is too high');
    end
end
