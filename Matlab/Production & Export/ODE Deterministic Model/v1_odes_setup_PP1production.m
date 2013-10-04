function [dx_dt]= v1_odes_setup_PP1production(t,x)

% Sets up an ODE system, based on the PP1 production system, with
% t=time & x which is a vector of variables:
% x=[x(1),x(2)]=[[mRNA],[PP1cyto]]

% Inputs: 
%      t: time variable
%      x: state variables as a vector
%
% Outputs:
%      dx_dt: RHS of the system of ODEs
%
% Usage:
% [t, x] = ode45(@v1_odes_setup_PP1production,[time interval],[initial conditions],[]);
% [t, x] = ode45(@v1_odes_setup_PP1production,[0,1200],[0,0],[]);

% Written by Craig Johnston, 17th June 2013


%%%%%%%%%%%%%%%%% Parameters %%%%%%%%%%%%%%%%%

KTl = (23E-9)/60;                               % PP1 transcription rate (M/s)
Kmdeg = 0.462/60;                               % mRNA degradation constant (/s)
KTc = 45/60;                                    % PP1 translation rate (/s)
Kpdeg = 1.15/60;                                % PP1 degradation constant (/s)            


% vector of variables                                              
% x(1) = [mRNA]
% x(2) = [PP1cyto]

% ODE system
% dx_dt(1) = dx(1)/dt = d[mRNA]/dt is the ODE for [mRNA]
% dx_dt(2) = dx(2)/dt = d[PP1cyto]/dt is the ODE for [PP1cyto]
      

dx_dt(1) = KTl - Kmdeg*x(1);
dx_dt(2) = KTc*x(1) - Kpdeg*x(2);


% dx_dt is a column vector of ODES

dx_dt = dx_dt';
            
% we tranpose to allow MATLAB to solve the ODE system as a row vector

end