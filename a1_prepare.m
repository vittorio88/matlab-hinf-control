%% Prepare Workspace
clc
clear all
s=tf('s');

%% Generate fixed frequency vectors
nPermutations=10; % how many pieces to divide uncertainty range in for Wu. (computationally expensive)
vector.log.slices=1000;
vector.log.freq.low=-2;
vector.log.freq.high=5;
vector.log.value = logspace(vector.log.freq.low,vector.log.freq.high,vector.log.slices); % Frequency vector for plotting (Goes from 10^-3 to 10^4. 3rd argument is how many slices)
