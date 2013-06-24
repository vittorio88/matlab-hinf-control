function [ signalInputFunction ] = buildsignalinputfunction( coeff, type, freq, h, frequencyVector )
%buildsignalinputfunction Given properties of function, creates corresponding
%function
%h: order
%freq: freq of sinusoidal signals
%type: 0 -> disabled, 1 -> polynomial, 2 -> sinusoidal
%coeff: coefficient of polynomial or sinusoidal function
% s=tf('s');

if type == 0
    signalInputFunction=0;
end

if type == 1
    if h == 0
        signalInputFunction = tf(coeff, 1);
    end
    if h == 1
        signalInputFunction = tf(coeff, [1 0]);
    end
    if h == 2
        signalInputFunction = tf(coeff, [1 0 0]);
    end
end

timeVector= 0:0.001:1;
if type == 2
    signalInputFunction=coeff*sin(freq*timeVector);
end




end

