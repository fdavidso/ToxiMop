%%%%%%%% v1_odes_solver_PP1production.m
%%%%%% Craig Johnston
%
%%%% The program, v1_odes_solver_PP1production, calls the function, 
% v1_odes_setup_PP1_TATproduction_export, to obtain the system of ODEs
% and solves the system numerically, for the vector of variables x, 
% over the given time interval. A selection of plots are output in the
% figures to visualise different results. 


clear
close all

%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
            

% options to reduce errors in solution
options = odeset('Refine',14,'AbsTol',1E-14, 'RelTol', 1E-12);


[t, x] = ode45(@v1_odes_setup_PP1production,[0,1200],[0,0],options);

% [t, x] = ode45(calls in  v1_odes_solver_PP1production,[time interval],[Initial Conditions]);
% Initial Conditions = [mRNA] ,[PP1cyto]]

% ode45 is a function used to solve differential equations numerically 

% x=[x(:,1),x(:,2)]=[[mRNA] ,[PP1cyto]]
% is a solution matrix of our variables
% each variable is evaluated at discrete times dt, within the
% given time interval.

% x(i,:) is the ith row of x gives the concentration values of variables
% at the ith discrete time in the interval.

% x(:,1)=[mRNA] the first column gives the mRNA concentrations at each time
% x(:,2)=[PP1cyto] the second column gives the PP1 concentrations at each time



x_conc = x;                                   % set up concentration vector               

% scaling on x_conc for plots
x_conc(:,1)= 1E7*(x(:,1));
x_conc(:,2)= 1E6*(x(:,2));


x_number = x;                                 % set up number vector

% number = concetration*volume*avagadro
x_number = x_number * vol * nA; 


% displays the number of PP1 in the cytoplasm 
disp('The number of PP1 in the cytoplasm is')
round(x_number(end,2))



%%%%%%%%%% Plots %%%%%%%%%%

% figure(1) - Concentration vs Time

figure(1);
        hold on
        plot(t,x_conc(:,1),'Color',[0.922,0.235,0.545],'LineWidth', 1.5,'LineSmoothing','on')
        plot(t,x_conc(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
        
        hleg1 = legend('mRNA (100nMol/ l)','PP1cyto (\muMol/ l)','Location', ([.19, .72, .1, .2]));
        xlabel('Time (s) ','FontSize',16)
        ylabel('Concentration ','FontSize',16)
        grid on
        axis([0 1200 0 2.5])
        set(gcf, 'renderer', 'opengl')

            
% figure(2) - Number of PP1cyto vs Time 
 
figure(2);
        plot(t,x_number(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
        
        xlabel('Time (s) ','FontSize',16)
        ylabel('Number of PP1cyto','FontSize',16)
        grid on
        axis([0 1200 0 1400])
        set(gcf, 'renderer', 'opengl')



% figure(3) - Combined subplot

figure(3)
        subplot(1,2,1)
                hold on
                plot(t,x_conc(:,1),'Color',[0.922,0.235,0.545],'LineWidth', 1.5,'LineSmoothing','on')
                plot(t,x_conc(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')

                hleg1 = legend('mRNA (100nMol/ l)','PP1cyto (\muMol/ l)','Location', ([.19, .72, .1, .2]));
                xlabel('Time (s) ','FontSize',16)
                ylabel('Concentration ','FontSize',16)
                grid on
                axis([0 1200 0 2.5])
                set(gcf, 'renderer', 'opengl')



        subplot(1,2,2)


                plot(t,x_number(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')

                xlabel('Time (s) ','FontSize',16)
                ylabel('Number of PP1cyto','FontSize',16)
                grid on
                axis([0 1200 0 1400])
                set(gcf, 'renderer', 'opengl')

