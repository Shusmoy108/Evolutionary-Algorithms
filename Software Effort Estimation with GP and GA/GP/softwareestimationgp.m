% Simple example for GP-OLS
%  Static function identification
% (Append the GpOls directory to the path)
%

clear all

%Regression matrix
ndata = 100;
nvar  = 1;
a = -2;
b = 2;
X = (b-a).*rand(ndata,nvar) + a;
M=xlsread("sd.xlsx");
k=M(:,2);
me=M(:,3);
ef=M(:,4);
X=[k me];
Y=[ef];
%X     = rand(ndata,nvar);

%Output vector (y = 10*x1 + 5*x2^2)
%Y = 10*X(:,1) + 5*X(:,2).^2;
%Y = 2*X(:,1) + 5*X(:,1).^2+ X(:,1).^3;
%Y = 2*X(:,1) + 5*X(:,2).^2+ X(:,3).^3;
%Y = Y + randn(size(Y))*0.01; %some 'measurement' noise

%GP equation symbols
symbols{1} = {'+','*',};
%symbols{2} = {'x','x*x','x*x*x'};  %length(symbols{2}) = size(X,2) !
symbols{2} = {'k','me'};

%Initial population
popusize     = 150;
maxtreedepth = 10;
popu         = gpols_init(popusize,maxtreedepth,symbols);

%first evaluation
opt   = [0.8 0.7 0.3 2 1 0.2 30 0.05 0 0];
popu  = gpols_evaluate(popu,1:popusize,X,Y,[],opt(5:8));

%info
disp(gpols_result([],0));
[s,tree,m] = gpols_result(popu,1);
disp(s);

%GP loops
ms=[];
ms(1)=m;
for c = 2:30,
  %iterate 
  popu = gpols_mainloop(popu,X,Y,[],opt);
  %info  
  [s,tree,m] = gpols_result(popu,1);
  ms(c)=m;
  disp(gpols_result(popu,1));
end

%Result
[s,tree,m] = gpols_result(popu,2);
ms(c)=m;
disp(s);

tree_draw(tree,symbols)
%=======================
% Draw the actual and estimated responses
%=======================
% x1 = X(:,1);
% x2 = X(:,2);
% x3 = X(:,3);
% y  = Y;
% yh =   2.418338 * (x3) + 4.848414 * ((x2).*(x2)) + 0.215857;
y=ef;
yh= -0.032001 * ((me).*(k)) + 2.368056 * (k) +0.847537;
% 
figure;
plot(ms,'LineWidth',1.5); 
title('Convergence Graph of Genetic Programing in COCOMO Parameter Estimation')
xlabel('Generations');
ylabel("Mean Square Error");
hold on;
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

