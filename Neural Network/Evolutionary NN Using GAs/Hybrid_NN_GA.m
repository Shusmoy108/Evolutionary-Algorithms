clc
clear all;
global net;
global inputs;
global targets;
%%
% INITIALIZE THE NEURAL NETWORK PROBLEM %
% inputs for the neural net
k       = 1:100;
inputs  = sin(2*k);
targets = 3*inputs + 4*inputs.^2 + 5*inputs.^3;
%%
% inputs = (1:10);
%%
% targets for the neural net
% targets = cos(inputs.^2);
%%
% Number of neurons
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
Fitness = @(x) mse_test(x);
%%
% Setting the Genetic Algorithms tuning parameters
%%
% opts = gaoptimset('TolFun', 1e-8,'display','iter');
opts = optimoptions(@ga,'PopulationSize',30);
opts = optimoptions(opts,'MaxStallGenerations',50,'MaxGenerations',25);
% opts = optimoptions(@ga,'MaxGenerations',25);
opts = optimoptions(opts,'SelectionFcn',@selectiontournament);
opts = optimoptions(opts,'PlotFcn',{@gaplotbestf});
%%
% Run GAs
%%
%%
% PLEASE NOTE: For a feed-forward network
% with n neurons, 3n+1 quantities are required
% in the weights and biases column vector.
%
% a. n for the input weights
% b. n for the input biases
% c. n for the output weights
% d. 1 for the output bias
% running the genetic algorithm with desired options
%%
lb      = [-1,-1];
ub      = [1 , 1];
Weights = 3*n+1;
%%
% Run GAs
%%
[x,fval,exitFlag,Output] = ga(Fitness,Weights,[],[],[],[],lb,ub,[],opts);
% [x,fval,exitflag,Output,Population] = ga(h, 3*n+1, opts);
% x is the values of the weights;
%%
fprintf('=====================================================\n');
fprintf('The number of generations is: %d\n', Output.generations);
fprintf('The number of function evaluations is: %d\n', Output.funccount);
fprintf('The best function value found is: %g\n', fval);
fprintf('=====================================================\n');
%%
%%
% simulate the net with the generated weights
yh = sim(net,inputs);
%%
figure(1);
plot(targets); hold on;
plot(yh,'r-.');
legend('Actual','Estimated');
%%
%%
function mse_calc = mse_test(x)
    global net;
    global inputs;
    global targets;
    
    % 'x' contains the weights and biases vector
    % in row vector form as passed to it by the
    % genetic algorithm. This must be transposed
    % when being set as the weights and biases
    % vector for the network.
    % To set the weights and biases vector to the
    % one given as input
    %%
    net = setwb(net, x');
    % To evaluate the ouputs based on the given
    % weights and biases vector
    %%
    y = net(inputs);
    % Calculating the mean squared error
    %%
    mse_calc = mse (y,targets);
    %sum((y-targets).^2)/length(y);
end