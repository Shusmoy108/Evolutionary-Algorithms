function [fmin0,gbest,Convergence_curve]=PSO(n,maxite,LB,UB,m,fobj)

if size(UB,1)==1
    UB=ones(m,1)*UB;
    LB=ones(m,1)*LB;
end

wmax=0.9; % inertia weight
wmin=0.4; % inertia weight
c1=2;     % acceleration factor
c2=2;     % acceleration factor
% pso main program----------------------------------------------------start
% maxite=1000; % set maximum number of iteration 

Convergence_curve=zeros(1,maxite);
x0 = initialization(n,m,UB,LB);

% size(x0)
x=x0; % initial population
v=0.1*x0; % initial velocity
for i=1:n
 f0(i,1)=fobj(x0(i,:));
end
[fmin0,index0]=min(f0);
pbest = x0; % initial pbest
gbest = x0(index0,:); % initial gbest
% pso initialization------------------------------------------------end

% pso algorithm---------------------------------------------------start
ite = 1;
tolerance = 1;

while ite<=maxite %&& tolerance>10^-12
    w=wmax-(wmax-wmin)*ite/maxite; % update inertial weight
    % pso velocity updates
    for i=1:n
        for j=1:m
            v(i,j)=w*v(i,j)+c1*rand()*(pbest(i,j)-x(i,j))...
                  +c2*rand()*(gbest(1,j)-x(i,j));
        end
    end
% pso position update
for i=1:n
    for j=1:m
        x(i,j)=x(i,j)+v(i,j);
    end
end
% handling boundary violations
for i=1:n
    for j=1:m
        if x(i,j)<LB(j)
            x(i,j)=LB(j);
        elseif x(i,j)>UB(j)
            x(i,j)=UB(j);
        end
    end
end
% evaluating fitness
for i=1:n
    f(i,1) = fobj(x(i,:));
end
% updating pbest and fitness
for i=1:n
    if f(i,1) < f0(i,1)
        pbest(i,:) = x(i,:);
        f0(i,1)=f(i,1);
    end
end

[fmin,index]=min(f0);   % finding out the best particle
%  ffmin(ite,run)=fmin; % storing best fitness
%  ffite(run)=ite; % storing iteration count
% updating gbest and best fitness

if fmin < fmin0
    gbest = pbest(index,:);
    fmin0 = fmin;
end
% calculating tolerance
%  if ite>100;
%  tolerance=abs(ffmin(ite-100,run)-fmin0);
%  end
% displaying iterative results
%  if ite==1
%  disp(sprintf('Iteration Best particle Objective fun'));
%  end
%  disp(sprintf('%8g %8g %8.4f',ite,index,fmin0));

Convergence_curve(ite) = fmin0;
ite = ite+1;
end
end
