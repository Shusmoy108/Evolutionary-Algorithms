clc
clear all;

%%
% INITIALIZE THE NEURAL NETWORK PROBLEM %
% inputs for the neural net
k = 1:100;
inputs  = sin(2*k);
%targets = 3*inputs + 4*inputs.^2 + 5*inputs.^3;

% inputs = (1:10);
%%
% targets for the neural net
targets = cos(inputs.^2);
%%
% number of neurons
n = 10;

%%
% create a neural network
net = feedforwardnet(n);

%%
% configure the neural network for this dataset
net = configure(net, inputs, targets);

%%
% create handle to the MSE_TEST function, that
% calculates MSE
Fitness = @(x) mse_test(x, net, inputs, targets);

%%
% Setting the PSO tolerance for
% minimum change in fitness function before
% terminating algorithm to 1e-8 and displaying
% each iteration's results.
% opts = optimopts('ga','PlotFcn',"gaplotbestf");
% opts = optimopts(opts,'MaxStallGenerations',50,'MaxGenerations',10);

lb = ones(1,n);
ub = 10*ones(1,n);
opts = optimoptions('particleswarm','SwarmSize',100);
% opts = optimoptions('particleswarm','PlotFcn',@pswplotbestf);
opts = optimoptions('particleswarm','MaxIterations',25);
opts = optimoptions('particleswarm','PlotFcn','pswplotbestf')
%%
%% Run PSO
% PLEASE NOTE: For a feed-forward network
% with n neurons, 3n+1 quantities are required
% in the weights and biases column vector.
%
% a. n for the input weights
% b. n for the input biases
% c. n for the output weights
% d. 1 for the output bias
% running the genetic algorithm with desired opts
%%
lb      = [-1,-1];
ub      = [1 , 1];
Weights = 3*n+1;
%%
% Run PSO
% [x,fval,exitflag,output] = particleswarm(Fitness, Weights,lb,ub,opts);
[x,fval,exitFlag,Output] = particleswarm(Fitness,Weights,lb,ub,opts);


%%
% simulate the net with the generated weights
yh = sim(net,inputs);
%%
%%

figure(1);
plot(targets); hold on;
plot(yh,'r-.');
legend('Actual','Estimated');


%%
function mse_calc = mse_test(x, net, inputs, targets)
    % 'x' contains the weights and biases vector
    % in row vector form as passed to it by the
    % genetic algorithm. This must be transposed
    % when being set as the weights and biases
    % vector for the network.
    % To set the weights and biases vector to the
    % one given as input
    net = setwb(net, x');
    % To evaluate the ouputs based on the given
    % weights and biases vector
    y = net(inputs);
    % Calculating the mean squared error
    mse_calc = mse (y,targets);
    %sum((y-targets).^2)/length(y);
end