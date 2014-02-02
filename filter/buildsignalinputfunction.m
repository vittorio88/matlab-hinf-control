function [ signalInputFunction ] = buildsignalinputfunction( values )
%buildsignalinputfunction Given properties of function, creates corresponding
%function
%h: order
%freq: freq of sinusoidal signals
%type: 0 -> disabled, 1 -> polynomial, 2 -> sinusoidal
%coeff: coefficient of polynomial or sinusoidal function
s=tf('s');

% no signal
if values.type == 0
    signalInputFunction=0;
end

% polynomial function
if values.type == 1
    signalInputFunction = values.coefficient/s^(values.order+1) * values.tf;
end

% sets gain of sinusoidal function for simulink
if values.type == 2
    signalInputFunction=values.coefficient * values.tf;
end




end

