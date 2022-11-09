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

function o=My_FNN(Ino,Hno,Ono,W,B,x1,x2,x3,x4)
h=zeros(1,Hno);
o=zeros(1,Ono);

for i=1:Hno
    h(i)=My_sigmoid(x1*W(i)+x2*W(Hno+i)+x3*W(2*Hno+i)+x4*W(3*Hno+i)+B(i));
end

k=3;
for i=1:Ono
    k=k+1;
    for j=1:Hno
        o(i)=o(i)+(h(j)*W(k*Hno+j));
    end
end
for i=1:Ono 
    o(i)=My_sigmoid(o(i)+B(Hno+i));
end

