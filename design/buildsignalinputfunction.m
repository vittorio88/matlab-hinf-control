function [ signalInputFunction ] = buildsignalinputfunction( coeff, type, freq, h, frequencyVector )
%buildsignalinputfunction Given properties of function, creates corresponding
%function
%h: order
%freq: freq of sinusoidal signals
%type: 0 -> disabled, 1 -> polynomial, 2 -> sinusoidal
%coeff: coefficient of polynomial or sinusoidal function
s=tf('s');

if type == 0
    signalInputFunction=0;
end

if type == 1
    signalInputFunction = coeff/s^(h+1);
end

% signal must be 1 for math to work for sinusoidal functions
if type == 2
    signalInputFunction=coeff;
end




end

