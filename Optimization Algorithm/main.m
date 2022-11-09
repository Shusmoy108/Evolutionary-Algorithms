%
clc
clear all;
close all;

run colors_definitions.m
warning off 

maxIteration    = 100;   % Maximum numbef of iterations
PopSize         = 100;   % Number of search agents
ElitistCheck    = 1; 
Rpower          = 1;
min_flag        = 1;      % 1: minimization, 0: maximization
F_index         = 1;
Pc              = 0.7;    % crossover rate
Pm              = 0.1;    % mutation rate
visualization   = 0;      % set to 0 if you do not want the conv. curve 
maxrun          = 1;
No_of_Funs      = 1;      % Number of benchmark functions

for k = 1:No_of_Funs
    Function_name   = sprintf('F%d',k); 
    %==================================================================
    % Load details of the selected benchmark function
    [lb,ub,dim,fobj]= Get_Functions_details(Function_name);

    func = sprintf('cec%d',k);
    %==================================================================
for runs =1:maxrun 
%     disp('----------------------------------------');
    [Best_score_GA, Best_pos_GA, cg_curve_GA] = ...
        GA (PopSize, maxIteration,lb,ub,Pc,Pm,dim,fobj);

    [Best_score_PSO,Best_pos_DO,cg_curve_DO]=...
        DO(PopSize,maxIteration,lb,ub,dim,fobj);
    [Best_score_DO,Best_pos_PSO,cg_curve_PSO]=...
        PSO(PopSize,maxIteration,lb,ub,dim,fobj);
    [Best_score_DE, Best_pos_DE, cg_curve_DE] = ...
        DE (PopSize, maxIteration,lb,ub,Pc,Pm,dim,fobj);
     [Best_score_CSA,  Best_pos_CSA,  cg_curve_CSA] = ...
         CSA(PopSize,maxIteration,lb,ub,dim,fobj);
     [Best_score_SSA,  Best_pos_SSA,  cg_curve_SSA] = ...
         SSA(PopSize,maxIteration,lb,ub,dim,fobj);
      [Best_score_BAT,  Best_pos_BAT,  cg_curve_BAT] = ...
         BAT(PopSize,maxIteration,lb,ub,dim,fobj);

    %==================================================================
%      gcf=figure (k);
%      set(gcf,'color','w');
    %==================================================================
    % Draw search space
    %==================================================================
%     subplot(1,2,1);
%     func_plot(Function_name);
%     title('Parameter space','interpreter','latex',...
%         'FontName','Times','fontsize',10);
%     xlabel('$z_1$','interpreter','latex','FontName','Times','fontsize',10);
%     ylabel('$z_2$','interpreter','latex','FontName','Times','fontsize',10); 
%     zlabel([Function_name,'($x_1$, $x_2$)'],'interpreter','latex',...
%         'FontName','Times','fontsize',10);     
    %==================================================================  
    %Draw objective space
    %==================================================================
    figure
    plot(cg_curve_GA,'LineWidth',1.5,'Color',color_scheme_set1(1,:));  
    hold on
    plot(cg_curve_PSO,'LineWidth',1.5,'Color',color_scheme_set1(2,:)); 
    hold on
    plot(cg_curve_DE,'LineWidth',1.5,'Color',color_scheme_set1(3,:));
    hold on
    plot(cg_curve_CSA,'LineWidth',1.5,'Color',color_scheme_set1(4,:));
    hold on
    plot(cg_curve_SSA,'LineWidth',1.5,'Color',color_scheme_set1(5,:));
    hold on
    plot(cg_curve_DO,'LineWidth',1.5,'Color',color_scheme_set1(6,:));
    hold on
    plot(cg_curve_BAT,'LineWidth',1.5,'Color',color_scheme_set1(7,:));
    hold on
    title({'Objective space','(Convergence characteristic)'},...
        'interpreter','latex','FontName','Times','fontsize',10);
    xlabel('Iteration','interpreter','latex',...
        'FontName','Times','fontsize',10)
    ylabel('Best score obtained so far','interpreter','latex',...
        'FontName','Times','fontsize',10); 
    legend("GA","PSO","DE", "CSA","SSA","DO","BAT");
    axis tight
    grid on
    box on
    
    display('----------------------------------')    
    display(['Function no: ===> ', num2str(k)]);
    display(['Fitness by GA is ', num2str(Best_score_GA)]);
    display(['The optimal value of the parameters ']);
    Best_pos_GA'
    display('----------------------------------')
%     Name = sprintf('fig%d.eps',k); 
%     eval(['print -depsc ' Name]);
end

end
