%% Prepare Workspace
clc
clear all
s=tf('s');

%% Generate fixed frequency vectors
nPermutations=10; % Vector representing how many pieces to divide uncertainty range into.
vector_log_slices=1000;
vector_log_freq_low=-2;
vector_log_freq_high=5;
vector_log = logspace(vector_log_freq_low,vector_log_freq_high,vector_log_slices); % Frequency vector for plotting (Goes from 10^-3 to 10^4. 3rd argument is how many slices)
vectorLog=vector_log;
nVectorLog=vector_log_slices;