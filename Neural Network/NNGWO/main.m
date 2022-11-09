%  Traning Feed-forward Neural Networks using Grey Wolf Optimizer   %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%                                                                   %
%   Main paper: S. Mirjalili,How effective is the Grey Wolf         %
%               optimizer in training multi-layer perceptrons       %
%              Applied Intelligece, in press, 2015,                 %
%               http://dx.doi.org/10.1007/s10489-014-0645-7         %
%                                                                   %

clear all
clc

SearchAgents_no=200; % Number of search agents
Max_iteration=250; % Maximum numbef of iterations

% Load details of the selected benchmark function
fobj=@MLP_Iris
lb=-10;
ub=10;
dim=75;

% Srat traning using GWO
[Best_MSE,Best_NN,cg_curve]=GWO(SearchAgents_no,Max_iteration,lb,ub,dim,fobj);

% Draw the convergence curve
figure('Position',[500 500 660 290])
semilogy(cg_curve,'Color','r')
hold on
title('Convergence curve')
xlabel('Iteration');
ylabel('MSE');

axis tight
grid off
box on
legend('GWO')

% Calculate the classification rate

% load the dataset and normalization
load iris.txt
x=sortrows(iris,2);
%I2=x(1:150,1:4);
H2=x(1:150,1);
H3=x(1:150,2);
H4=x(1:150,3);
H5=x(1:150,4);
T=x(1:150,5);
%I=(I2-0.1)./(7.9-0.1)
H2=H2';
[xf,PS] = mapminmax(H2);
I2(:,1)=xf;

H3=H3';
[xf,PS2] = mapminmax(H3);
I2(:,2)=xf;

H4=H4';
[xf,PS3] = mapminmax(H4);
I2(:,3)=xf;

H5=H5';
[xf,PS4] = mapminmax(H5);
I2(:,4)=xf;
Thelp=T;
T=T';
[yf,PS5]= mapminmax(T);
T=yf;
T=T';


Rrate=0;

% Load the obtained optimal values for weights and biases
W=Best_NN(1:63);
B=Best_NN(64:75);

for pp=1:150
    actualvalue=My_FNN(4,9,3,W,B,I2(pp,1),I2(pp,2), I2(pp,3),I2(pp,4));
    if(T(pp)==-1)
        if (actualvalue(1)>=0.95 && actualvalue(2)<0.05 && actualvalue(3)<0.05)
            Rrate=Rrate+1;
        end
    end
    if(T(pp)==0)
        if (actualvalue(1)<0.05 && actualvalue(2)>=0.95 && actualvalue(3)<0.05)
            Rrate=Rrate+1;
        end
    end
    if(T(pp)==1)
        if (actualvalue(1)<0.05 && actualvalue(2)<0.05 && actualvalue(3)>=0.95)
            Rrate=Rrate+1;
        end
    end
end

Classification_rate=(Rrate/150)*100
