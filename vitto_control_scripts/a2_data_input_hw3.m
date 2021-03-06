%%% DATA INPUT
%% Controller values
Gs=1; % Sensor Gain
Ga=0.095; % Actuator
Gr=1; % Prefilter ( reference generator )
Gd=1; % Plant disturbance

Kd=1; % Proportion between input and output

%% Input values

% Input Coefficients
dr_coeff=1; % Value of Reference input
da_coeff=5.5*10^(-3); % Value of Actuator input
dp_coeff=2*10^(-2); % Value of Plant input
ds_coeff=10^(-1); % Value of Sensor input

% Error tolerances
dr_error_max=1.5*10^(-1); % Max output error due to reference input
da_error_max=1.5*10^(-2); % Max output error in presence of da
dp_error_max=5*10^(-4); % Max output error in presence of dp
ds_error_max=5*10^(-4); % Max output error in presence of ds

% Type of disturbance ( 0 for none, 1 for polynomial, 2 for sinusoidal )
dr_type=1; % Reference input type
da_type=1; % Actuator disturbance type
dp_type=2; % Plant disturbance type
ds_type=2; % Sensor disturbance type

% For sinusoidal inputs (frequency) [rad/s]
dr_freq=0; % Value of Reference input frequency
da_freq=0; % Value of Actuator input frequency
dp_freq=0.02; % Value of Plant input frequency
ds_freq=2800; % Value of Sensor input frequency

% Input order ( Only for polynomial inputs (type=-10 for all others) )
dr_h=1;
da_h=0;
dp_h=-10;
ds_h=-10;


%% Time-Domain Performance Specifications
rise_time_on=1;
overshoot_on=1;
settling_time_on=0;

rise_time=3; % Max Rise time in seconds tr
overshoot=0.10; % Max overshoot from a step response (s^)
settling_time=12; % Max time with which an input must be settled
settling_time_tolerance=0.05; % DECIMAL Tolerance defining distance of value from Yss at which a function is considered settled. ( alpha)


%% Plant Values

% Number of uncertain coefficients
nGp_coeffs=2;

% Coefficient 1 range (set to 0 if it doesn't exist)
Gp_coeff1_low=10;
Gp_coeff1_high=30;

% Coefficient 2 range (set to 0 if it doesn't exist)
Gp_coeff2_low=160;
Gp_coeff2_high=240;

% Coefficient 3 range (set to 0 if it doesn't exist)
Gp_coeff3_low=0;
Gp_coeff3_high=0;

% Plant transfer function string for further processing
Gp_string='(2*(10^5)*(s + Gp_coeff1))/((s - 20)*(s + Gp_coeff2)*(s/200+1))';

% Gp poles at s=0
nGp_poles=1;


