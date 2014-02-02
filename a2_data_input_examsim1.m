%%% DATA INPUT

%% Controller values
Gs=1; % Sensor Gain
Ga=3; % Actuator
Gr=1; % Prefilter ( reference generator )
Gd=1; % Plant disturbance
Kd=2; % Proportion between input and output

%% Create signal input structs
% coefficient: signal input coefficientvalue
% maxError: max output error
% type: 0 for none, 1 for polynomial, 2 for sinusoidal
% frequency: only for sinusoidal signals in rad/sec. NaN for all others
% order: only for polynomial signals. NaN for all others
% tf: equal to input signal transfer function or gain block
% on: must always be initialized to 1 unless signal is not present

r.values=struct('coefficient', 1 ...
    , 'type', 1 ...
    , 'frequency', NaN ...
    , 'order', 0 ...
    , 'tf', Gr ...
    , 'on', 1 ...
    );
r.errors=struct('max', 1.5*10^(-1) ...
    , 'calculated', NaN ...
    , 'simulated', NaN ...
    );


da.values=struct('coefficient', 8.5*10^(-3) ...
    , 'type', 1 ...
    , 'frequency', NaN ...
    , 'order', 0 ...
    , 'tf', 1 ...
    , 'on', 1 ...
    );
da.errors=struct('max', 25*10^(-3) ...
    , 'calculated', NaN ...
    , 'simulated', NaN ...
    );


dp.values=struct('coefficient', 6*10^(-2) ...
    , 'type', 2 ...
    , 'frequency', 10 ...
    , 'order', NaN ...
    , 'tf', Gd ...
    , 'on', 1 ...
    );
dp.errors=struct('max',  6*10^(-4) ...
    , 'calculated', NaN ...
    , 'simulated', NaN ...
    );

ds.values=struct('coefficient', 1*10^(-3) ...
    , 'type', 2 ...
    , 'frequency', 10000 ...
    , 'order', NaN ...
    , 'tf', 1 ...
    , 'on', 1 ...
    );
ds.errors=struct('max',  1*10^(-4) ...
    , 'calculated', NaN ...
    , 'simulated', NaN ...
    );



%% Create Simulink bus object using values struct
busInfo = Simulink.Bus.createObject(r.values);


%% Time-Domain Performance Specifications

riseTime.on=1;
riseTime.maxValue=5e-3;

overshoot.on=1;
overshoot.maxValue=0.08;

settlingTime.on=0;
settlingTime.maxValue=12;
settlingTime.tolerance=0.05;

%% Plant Values
Gp.inputString='(10e6*K)/((s^2 + P*s))';
Gp.coefficient(1)=struct('name','K'...
    ,'low', 0.8 ...
    ,'high', 1.2 );
Gp.coefficient(2)=struct('name','P'...
    ,'low', 420 ...
    ,'high', 580 );



