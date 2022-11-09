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

function o=MLP_Iris(solution)

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


for ww=1:63
    W(ww)=solution(1,ww);
end
for bb=64:75
    B(bb-63)=solution(1,bb);
end
fitness=0;
for pp=1:150
    actualvalue=My_FNN(4,9,3,W,B,I2(pp,1),I2(pp,2), I2(pp,3),I2(pp,4));
    if(T(pp)==-1)
        fitness=fitness+(1-actualvalue(1))^2;
        fitness=fitness+(0-actualvalue(2))^2;
        fitness=fitness+(0-actualvalue(3))^2;
    end
    if(T(pp)==0)
        fitness=fitness+(0-actualvalue(1))^2;
        fitness=fitness+(1-actualvalue(2))^2;
        fitness=fitness+(0-actualvalue(3))^2;
    end
    if(T(pp)==1)
        fitness=fitness+(0-actualvalue(1))^2;
        fitness=fitness+(0-actualvalue(2))^2;
        fitness=fitness+(1-actualvalue(3))^2;
    end
end
fitness=fitness/150;
o=fitness;
end