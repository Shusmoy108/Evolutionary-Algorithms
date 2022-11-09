function o = fitness(a)

%load MyData;
M=xlsread("sd.xlsx");
k=M(:,2);
me=M(:,3);
ef=M(:,4);
%em=a(1)*k.^a(2); %model 1
% a(1)=-10;
% a(2)=-0.3670
% a(3)=0.2107
%em=a(1)*k.^a(2) + a(3).*me; %model 2
%em=a(1)*k.^a(2) + a(3).*me +a(4); %model 3
em= a(1) * ((k).*(me)) + a(2) * (k) + a(3); %model 4 from GP
%ym = a(1).*u + a(2)*u.^2 + a(3)*u.^3;
%o=(1-var(ef-em)\var(ef))*100;
o = mse(ef,em);

