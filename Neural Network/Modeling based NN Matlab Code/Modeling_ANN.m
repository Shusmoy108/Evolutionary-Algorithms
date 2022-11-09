% ***********************************
% MATLAB source code of ANN model
% ***********************************
clc
clear all;
format short g;
nntwarn off
%%
% INITIALIZE THE NEURAL NETWORK PROBLEM %
% inputs for the neural net
k = 1:100;
inputs  = sin(2*k);
targets = 3*inputs + 4*inputs.^2 + 5*inputs.^3;
%%
%*******************************************
n  = length(inputs);
m  = length(targets);
%*******************************************
%%
hn  = 15;  % Number of hidden nodes
% net = newff(ut',yt',hn);
net = ...
    newff(inputs,targets,[hn 1],{'tansig' 'purelin'},'trainlm','learngdm','mse');
% net.trainParam.goal         = 1e-25;
% net.trainParam.epochs       = 700;
% net.trainParam.max_fail     = 5000; 
% net.trainParam.show         = 5;
% net.trainParam.mu_dec       = 1e-5;
% net.trainParam.mu_inc       = 2;
% net.trainParam.mu_max       = 10000;
% net.trainParam.min_grad     = 1e-5;
% net.trainParam.mu         = 1e-25;
% net.trainParam.min_grad   = 1e-10;
% net.trainParam.mu         = 1e-10;
%%
% ****************************************************
% Training the Net
% ****************************************************
%%
net      = init(net);
[net,tr] = train(net,inputs,targets);
% ****************************************************
% Simulation and calculating error
% ****************************************************
%%
yh   = sim(net,inputs)';
% ****************************************************
% NN convergence
% ****************************************************
%%
figure(1)
semilogy(tr.epoch,tr.perf,'LineWidth',2);
xlabel('{\bf Epochs}'); grid;
ylabel('{\bf MSE}');
title('{\bf NN convergence}');
%%
%%
figure(2);
plot(targets); hold on;
plot(yh,'r-.');
legend('Actual','Estimated');