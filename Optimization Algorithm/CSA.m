
%% %  Crow Swarm Algorithm (CSA)  

function [fit_mem,g_best,cg_curve]=CSA(searchAgents,maxite,l,u,dim,fobj)

warning off;

format longe;

if size(u,1)==1
    u=ones(dim,1)*u;
    l=ones(dim,1)*l;
end
 
pd= dim;         % Problem dimension (number of decision variables)
N = searchAgents; % Flock (population) size
AP= 0.1;         % Awareness probability
fl= 2.0;         % Flight length (fl)

cg_curve=zeros(1,maxite);

% CSA initialization
% [x l u]=initCSA(N,pd); % Function for initialization % initialization_CSA
 
for i=1:N % Generation of initial solutions (position of crows)
    for j=1:pd
        x(i,j)=l(j)-(l(j)-u(j))*rand; % Position of the crows in the space
    end
end

xn=x;

for i=1:searchAgents
     ft(i,1)=fobj(xn(i,:));
end

mem=x; % Memory initialization
fit_mem=ft; % Fitness of memory positions

tmax=maxite; % Maximum number of iterations (itermax)

% Main loop
for t=1:tmax

%     fll = 100*exp(-sqrt(t))  ;
    num=ceil(N*rand(1,N)); % Generation of random candidate crows for following (chasing)
    for i=1:N
        if rand>AP
            xnew(i,:)= x(i,:)+fl*rand*(1*mem(num(i),:)-x(i,:)); % Generation of a new position for crow i (state 1)
        else
            for j=1:pd
                xnew(i,j)=l(j)-(l(j)-u(j))*rand; % Generation of a new position for crow i (state 2)
            end
        end
    end

    xn=xnew;
    for i=1:searchAgents
        
        ft(i,1)=fobj(xn(i,:));

    end
    
    for i=1:N % Update position and memory
        
        if xnew(i,:)>=l & xnew(i,:)<=u
            x(i,:)=xnew(i,:); % Update position
            if ft(i)<fit_mem(i)
                mem(i,:)= xnew(i,:); % Update memory fll*xnew(i,:); % Update memory
                fit_mem(i)=ft(i);
            end
        end
    end
    
% % displaying iterative results
        

%      outmsg = ['Iteration# ', num2str(t) , 'fit_mem= ' , num2str(min(fit_mem))];
%         disp(outmsg);
  
        cg_curve(t)=min(fit_mem); % Best found value until iteration t
    min(fit_mem) ;
end

ngbest=find(fit_mem== min(fit_mem)) ;
 
g_best=mem(ngbest(1),:) ; % Solutin of the problem
fit_mem= min(fit_mem)  ;

 %%%%%%%%%

% close;

g_best=g_best;

end