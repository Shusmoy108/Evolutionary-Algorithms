figure;
load cocomo1.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2,Color='r');
xlabel('Iteration');
ylabel('MSE');
%grid on;
hold on;
load cocomo2.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2,Color='m');
hold on;
load cocomo3.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2, Color='c');
hold on;
load cocomo4.mat
%semilogy(BestCost,'LineWidth',2);
plot(BestCost,'LineWidth',2);
hold on;
legend('model1','model2','model3','model4')