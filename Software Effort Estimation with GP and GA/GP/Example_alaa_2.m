% Simple example for GP-OLS
%  Static function identification
% (Append the GpOls directory to the path)
%
clc;
clear all;

%Regression matrix
ndata = 100;
nvar  = 2;
X     = rand(ndata,nvar);

%Output vector (y = 10 x1 + 5 x2^2 + 20 x1 x2)
Y = 10*X(:,1) + 5*X(:,2).^2 + 20*X(:,1).*X(:,2);
Y = Y + randn(size(Y))*0.01; %some 'measurement' noise

%GP equation symbols
symbols{1} = {'+','*'};
symbols{2} = {'x1','x2'};  %length(symbols{2}) = size(X,2) !

%Initial population
popusize     = 40;
maxtreedepth = 5;
popu         = gpols_init(popusize,maxtreedepth,symbols);

%first evaluation
opt   = [0.8 0.7 0.3 2 1 0.2 30 0.05 0 0];
popu  = gpols_evaluate(popu,[1:popusize],X,Y,[],opt(6:9));

%info
disp(gpols_result([],0));
disp(gpols_result(popu,1));

%GP loops
for c = 2:20,
  %iterate 
  popu = gpols_mainloop(popu,X,Y,[],opt);
  %info  
  disp(gpols_result(popu,1));
end

%Result
[s,tree] = gpols_result(popu,2);
disp(s);

tree_draw(tree,symbols)
%=======================
% Draw the actual and estimated responses
%=======================
x1 = X(:,1);
x2 = X(:,2);
y  = Y;
yh = 6.121782 * (x2) + 17.420902 * (((x2).*(x2)).*(x1)) ...
   + 14.247572 * (x1) -1.455092;

figure;
subplot(211);
plot(y,'LineWidth',1.5); hold on;
plot(yh,'r-.','LineWidth',1.5); grid;
xlabel('Samples','interpreter','latex','FontName','Times','fontsize',10)
ylabel('Amplitude','interpreter','latex','FontName','Times','fontsize',10); 
title('Actual and Estimated Responses','interpreter','latex','FontName','Times','fontsize',10); 
legend('Actual','Estimated')
subplot(212);
plot(y-yh,'LineWidth',1.5); grid; 
xlabel('samples','interpreter','latex','FontName','Times','fontsize',10)
title('$e=y-\hat{y}$','interpreter','latex','FontName','Times','fontsize',10); 



