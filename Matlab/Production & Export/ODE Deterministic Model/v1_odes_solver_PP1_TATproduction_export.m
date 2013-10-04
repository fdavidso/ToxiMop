%%%%%%%% v1_odes_solver_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v1_odes_solver_PP1_TATproduction_export, calls the function, 
% v1_odes_setup_PP1_TATproduction_export, to obtain the system of ODEs
% and solves the system numerically, for the vector of variables x, 
% over the given time interval. A selection of plots are output in the
% figures to visualise different results. 


clear
close all

%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
            
TatAassembly_number = 30;                    % TatAassembly is an assembly of 20 TatA proteins
TatBC_number = 15;                            % TatBC is a complex of TatB and TatC proteins

TatAassembly_conc = (TatAassembly_number/nA) / vol;               
TatBC_conc = (TatBC_number/nA) / vol; 

 
 
% options to reduce errors in solution
options = odeset('Refine',14,'AbsTol',1E-14, 'RelTol', 1E-12);


[t, x] = ode45(@v1_odes_setup_PP1_TATproduction_export,[0,1200],[0,0,TatBC_conc,0,TatAassembly_conc,0,0],options);

% [t, x] = ode45(calls in  v1_odes_solver_PP1_TATproduction_export,[time interval],[Initial Conditions]);
% Initial Conditions = [mRNA] ,[PP1cyto],[TatB-C],[PP1B-C],[TatAassembly],[PP1export],[PP1peri]]

% ode45 is a function used to solve differential equations numerically 

% x=[x(:,1),x(:,2),x(:,3),x(:,4),x(:,5),x(:,6),x(:,7)]=[[mRNA] ,[PP1cyto],[TatB-C],[PP1B-C],[TatAassembly],[PP1export],[PP1peri]]
% is a solution matrix of our variables
% each variable is evaluated at discrete times dt, within the
% given time interval.

% x(i,:) is the ith row of x gives the concentration values of variables
% at the ith discrete time in the interval.

% x(:,1)=[mRNA] the first column gives the mRNA concentrations at each time
% x(:,2)=[PP1cyto] the second column gives the PP1 concentrations at each time
% etc


x_conc = x;                                   % set up concentration vector               

% scaling on x_conc for plots
x_conc(:,1)= 1E8*(x(:,1));
x_conc(:,2)= 1E7*(x(:,2));
x_conc(:,3)= 1E8*(x(:,3));
x_conc(:,4)= 1E8*(x(:,4));
x_conc(:,5)= 1E8*(x(:,5));
x_conc(:,6)= 1E12*(x(:,6));
x_conc(:,7)= 1E8*(x(:,7));

x_number = x;                                 % set up number vector

% number = concetration*volume*avagadro
x_number = x_number * vol * nA; 



x_scaled_number = x;                          % set up scaled number vector

% scaling on x_scaled_number for plots                   
x_scaled_number(:,2)= 1E-1*x_number(:,2);
x_scaled_number(:,7)= x_number(:,7);


% displays the number of PP1 in the cytoplasm & periplasm  
disp('The number of PP1 in the cytoplasm is')
round(x_number(end,2))

disp('The number of PP1 in the periplasm is')
round(x_number(end,7))


%%%%%%%%%% Plots %%%%%%%%%%

% figure(1) - TatB-C vs Time all variables

figure(1);
        plot(t,x_conc(:,3),'Color',[0.447,0.447,0.447],'LineWidth', 1.5,'LineSmoothing','on')
        
        hleg1 = legend('TatB-C(10nMol/ l) ','Location', ([.19, .72, .1, .2]));
        xlabel('Time (s) ','FontSize',16)
        ylabel('Concentration ','FontSize',16)
        grid on
        set(gcf, 'renderer', 'opengl')
        
        
% figure(2) - TatAassembly vs Time 

figure(2);
        plot(t,x_conc(:,5),'Color',[0,0.329,0.651],'LineWidth', 1.5,'LineSmoothing','on')

        hleg1 = legend('TatAassembly (10nMol/ l)','Location', ([.19, .72, .1, .2]));
        xlabel('Time (s) ','FontSize',16)
        ylabel('Concentration ','FontSize',16)
        grid on
        set(gcf, 'renderer', 'opengl')
    
        
% figure(3) - Concentration vs Time product variables  

figure(3);
        hold on
        plot(t,x_conc(:,1),'Color',[0.922,0.235,0.545],'LineWidth', 1.5,'LineSmoothing','on')
        plot(t,x_conc(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
        plot(t,x_conc(:,6),'Color',[0.780,0.898,0.278],'LineWidth', 1.5,'LineSmoothing','on')
        plot(t,x_conc(:,7),'Color',[0.224,0.686,0.812],'LineWidth', 1.5,'LineSmoothing','on')

        hleg1 = legend('mRNA (10nMol/ l)','PP1cyto (100nMol/ l)','PP1export (pMol/ l) ', 'PP1peri (10nMol/ l) ','Location', ([.19, .72, .1, .2]));
        xlabel('Time (s) ','FontSize',16)
        ylabel('Concentration ','FontSize',16)
        grid on
        axis([0 1200, 0 45])
        set(gcf, 'renderer', 'opengl')

            
 % figure(4) - Number of PP1 vs Time (cytoplasm & periplasm)
 
figure(4);
        hold on

        plot(t,x_scaled_number(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
        plot(t,x_scaled_number(:,7),'Color',[0.224,0.686,0.812],'LineWidth', 1.5,'LineSmoothing','on')

        hleg1 = legend('PP1cyto (x10)', 'PP1peri' , 'Location', ([.19, .72, .1, .2]));
        xlabel('Time (s) ','FontSize',16)
        ylabel('Number','FontSize',16)
        grid on
        axis([0 1200, 0 220])
        set(gcf, 'renderer', 'opengl')
        
% figure(5) - figure(3) and figure(4) combined subplot
        
figure(5); 
        subplot(1,2,1)
                hold on
                plot(t,x_conc(:,1),'Color',[0.922,0.235,0.545],'LineWidth', 1.5,'LineSmoothing','on')
                plot(t,x_conc(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
                plot(t,x_conc(:,6),'Color',[0.780,0.898,0.278],'LineWidth', 1.5,'LineSmoothing','on')
                plot(t,x_conc(:,7),'Color',[0.224,0.686,0.812],'LineWidth', 1.5,'LineSmoothing','on')

                hleg1 = legend('mRNA (10nMol/ l)','PP1cyto (100nMol/ l)','PP1export (pMol/ l) ', 'PP1peri (10nMol/ l) ','Location', ([.19, .72, .1, .2]));
                xlabel('Time (s) ','FontSize',16)
                ylabel('Concentration ','FontSize',16)
                grid on
                axis([0 1200, 0 45])
                set(gcf, 'renderer', 'opengl')
                
        subplot(1,2,2)
                hold on

                plot(t,x_scaled_number(:,2),'Color',[1,0.525,0.365],'LineWidth', 1.5,'LineSmoothing','on')
                plot(t,x_scaled_number(:,7),'Color',[0.224,0.686,0.812],'LineWidth', 1.5,'LineSmoothing','on')

                hleg1 = legend('PP1cyto (x10)', 'PP1peri' , 'Location', ([.19, .72, .1, .2]));
                xlabel('Time (s) ','FontSize',16)
                ylabel('Number','FontSize',16)
                grid on
                axis([0 1200, 0 220])
                set(gcf, 'renderer', 'opengl')
        
        





