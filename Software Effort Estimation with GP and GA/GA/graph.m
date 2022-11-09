figure;
load cocomo1.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2,Color='r');
xlabel('Iteration');
ylabel('MSE');
grid on;
hold on;
load cocomo2.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2,Color='m');
load cocomo3.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2);