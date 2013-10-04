function [dx_dt]= v2_odes_setup_PP1_TATproduction_export(t,x)

% Sets up an ODE system, based on the PP1 production system, with
% t=time & x which is a vector of variables:
% x=[x(1),x(2),x(3),x(4),x(5),x(6),x(7)]=[[mRNA],[PP1cyto],[TatB-C],[PP1B-C],[TatAassembly],[PP1export],[PP1peri]]

% Inputs: 
%      t: time variable
%      x: state variables as a vector
%
% Outputs:
%      dx_dt: RHS of the system of ODEs
%
% Usage:
% [t, x] = ode45(@v2_odes_setup_PP1_TATproduction_export,[time interval],[initial conditions],[]);
% [t, x] = ode45(@v2_odes_setup_PP1_TATproduction_export,[0,1200],[0,0],[]);

% Written by Craig Johnston, 29th July 2013

%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%

KTl = (23E-9)/60;                               % PP1 transcription rate (M/s)
Kmdeg = 0.462/60;                               % mRNA degradation constant (/s)
KTc = 45/60;                                    % PP1 translation rate (/s)
Kpdeg = 1.15/60;                                % PP1 degradation constant (/s    
K1 = (4.8E5)/60;                                % PP1cyto & TatB-C recognition binding rate (/M.s)
Kr1 = 0.08/60;                                  % PP1B-C unbinding rate (/s)
K2 = (120E6)/(60);                              % Assembly association rate /M/s 
Kr2 = 0.1/60;                                   % PP1export disassociation rate (/s)                                               
K3 = 10;                                        % Export rate(/s)    


% vector of variables                                              
% x(1) = [mRNA]
% x(2) = [PP1cyto]
% x(3) = [TatB-C]
% x(4) = [PP1B-C]
% x(5) = [TatAassembly]
% x(6) = [PP1export]
% x(7) = [PP1peri]

% ODE system
% dx_dt(1) = dx(1)/dt = d[mRNA]/dt is the ODE for [mRNA]
% dx_dt(2) = dx(2)/dt = d[PP1cyto]/dt is the ODE for [PP1cyto]
% etc          

dx_dt(1) = KTl - Kmdeg*x(1);
dx_dt(2) = KTc*x(1) - Kpdeg*x(2)-K1*x(2)*x(3)+Kr1*x(4);
dx_dt(3) = -K1*x(2)*x(3)+ Kr1*x(4)+K3*x(6);
dx_dt(4) = K1*x(2)*x(3) - Kr1*x(4)-K2*x(4)*x(5)+Kr2*x(6);
dx_dt(5) = -K2*x(4)*x(5)+Kr2*x(6) + K3*x(6);
dx_dt(6) = K2*x(4)*x(5)-Kr2*x(6)-K3*x(6);
dx_dt(7) = K3*x(6);

% dx_dt is a column vector of ODES

dx_dt = dx_dt';
            
% we tranpose to allow MATLAB to solve the ODE system as a row vector

end