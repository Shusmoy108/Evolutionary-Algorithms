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
T=xlsread("PM10_dataset.xlsx");
data=T;
PD = 0.20 ;  % percentage 80%
Ptest = T(1:round(PD*length(T)),:); 
Ptrain = T(round(PD*length(T))+1:end,:);

train_inputs  = [Ptrain(:,1) Ptrain(:,2) Ptrain(:,3) Ptrain(:,4) Ptrain(:,5) Ptrain(:,6) Ptrain(:,7)]';
test_inputs  = [Ptest(:,1) Ptest(:,2) Ptest(:,3) Ptest(:,4) Ptest(:,5) Ptest(:,6) Ptest(:,7)]';
%inputs  = [data(:,1)]';
train_targets = [Ptrain(:,8)]';
test_targets = [Ptest(:,8)]';
figure(1);
subplot(4,2,1);
plot(data(:,1));
title('Subplot 1: WD')
hold on;
subplot(4,2,2); 
plot(data(:,2));
title('Subplot 2: WS')
hold on;
subplot(4,2,3); 
plot(data(:,3));
title('Subplot 3: NO')
hold on;
subplot(4,2,4);
plot(data(:,4));
title('Subplot 4: NO2')
hold on;
subplot(4,2,5); 
plot(data(:,5));
title('Subplot 5: CO')
hold on;
subplot(4,2,6); 
plot(data(:,6));
title('Subplot 6: O3_Aver')
hold on;
subplot(4,2,7); 
plot(data(:,8));
title('Subplot 7: AMP_TMP')
hold on;
subplot(4,2,8); 
plot(data(:,8));
title('Subplot 8: PM10')
hold on;
%targets=target';
%%
%*******************************************
%n  = length(inputs);
%m  = length(targets);
%*******************************************
%%
hn  = 20;  % Number of hidden nodes
% net = newff(ut',yt',hn);
net = ...
    newff(train_inputs,train_targets,[hn 1],{'tansig' 'purelin'},'trainlm','learngdm','mse');
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
[net,tr] = train(net,train_inputs,train_targets);
% ****************************************************
% Simulation and calculating error
% ****************************************************
%%
yh   = sim(net,train_inputs)';
yt   = sim(net,test_inputs)';
% ****************************************************
% NN convergence
% ****************************************************
%%
mse_train=mse(train_targets,yh);
mse_test=mse(test_targets,yt);
figure(2)
subplot(2,1,1);
semilogy(tr.epoch,tr.perf,'LineWidth',2);
xlabel('{\bf Epochs}'); grid;
ylabel('{\bf MSE}');
title('{\bf NN convergence for train Data}');
%%
%%
err=test_targets'-yt;
err=err.^2;
subplot(2,1,2);
semilogy(err,'LineWidth',2);
xlabel('{\bf Inputs Number}'); grid;
ylabel('{\bf Square Error}');
title('{\bf Square Error for each test data}');
%%
%%
figure(3);
subplot(2,1,1);
plot(train_targets); hold on;
plot(yh,'r-.');
legend('Actual','Estimated');
title('{\bf Actual Vs Estimated in Train Data}');
subplot(2,1,2);
plot(test_targets); hold on;
plot(yt,'r-.');
legend('Actual','Estimated');
title('{\bf Actual Vs Estimated in Test Data}');
