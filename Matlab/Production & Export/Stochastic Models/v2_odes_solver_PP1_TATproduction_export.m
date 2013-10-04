%%%%%%%% v2_odes_solver_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v2_odes_solver_PP1_TATproduction_export, is called into
% the program, v2_ssa_PP1_TATproduction_export.m, to plot the deterministic 
% curves for PP1cyto and PP1peri numbers onto the correspoding Stochastic
% Simulation Algortithm graphs. 
%
% The program calls the function, v2_odes_setup_PP1_TATproduction_export, 
% to obtain the system of ODEs and solves the system numerically, 
% for the vector of variables x, over the given time interval.


%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
            
TatAassembly_number = 30;                    % TatAassembly is an assembly of 20 TatA proteins
TatBC_number = 15;                            % TatBC is a complex of TatB and TatC proteins

TatAassembly_conc = (TatAassembly_number/nA) / vol;               
TatBC_conc = (TatBC_number/nA) / vol; 

 
 
% options to reduce errors in solution
options = odeset('Refine',14,'AbsTol',1E-14, 'RelTol', 1E-12);


[t, x] = ode45(@v2_odes_setup_PP1_TATproduction_export,[0,1200],[0,0,TatBC_conc,0,TatAassembly_conc,0,0],options);

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


x_number = x;                                 % set up number vector

% number = concetration*volume*avagadro
x_number(:,2)=(x(:,2))* vol * nA; 
x_number(:,7)=(x(:,7))* vol * nA;

% displays the number of PP1 in the cytoplasm & periplasm            
% displays the number of PP1 in the cytoplasm & periplasm  
disp('The number of PP1 in the cytoplasm is')
round(x_number(end,2))

disp('The number of PP1 in the periplasm is')
round(x_number(end,7))





