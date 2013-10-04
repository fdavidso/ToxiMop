function[PP1cyto,PP1peri,T,tnew,ynew,znew] = ssa_PP1_TATproduction_export(TatAassembly_conc,TatBC_conc,j,PP1cyto,PP1peri)

% % Implementation of the Stochastic Simulation Algorithm
% (or Gillespie's algorithm) on the PP1 production & export system which
% was developed by Dundee iGEM Modelling team.
% D J Higham, 2006.

% Uses Gillespie's algorithm to calculate numerically the Stochastic change 
% in PP1cyto & PP1peri numbers, for the jth realisation and the given
% TatAassembly_conc and TatBC_conc input configuration. The change is 
% based on our system over the selected time interval and the values are 
% stored in the jth column of PP1cyto and PP1peri matrices respectively. 
% The function passes additional plot data and these modified matrices,
% PP1peri & PP1cyto, into programs calling it. 

% Inputs: 
%      TatAassembly_conc: TatAassembly concentration
%      TatBC_conc: TatBC complex concentration
%      j: realisation number
%      PP1cyto: matrix to store PP1cyto numbers for each time and realisation
%      PP1peri: matrix to store PP1peri numbers for each time and realisation
%
% Outputs:
%      PP1cyto: matrix with PP1cyto numbers for each time and realisation
%      PP1peri: matrix with PP1peri numbers for each time and realisation
%      T: uniform time vector for the time interval
%      ynew: is the non-interpolated PP1cyto numbers
%      znew: is the non-interpolated PP1peri numbers
%      tnew: non-uniform time corresponding to reaction time for ynew, znew
%
% Usage:
% [PP1cyto,PP1peri,T,tnew,ynew,znew] = ssa_PP1_TATproduction_export(TatAassembly_conc,TatBC_conc,j,PP1cyto,PP1peri); 

% Written by Craig Johnston, 22nd July 2013

% % % % % % % % % % % % % % % % % Parameters

% Stoichiometric matrix
V = [1 -1 0 0 0 0 0 0 0; 0 0 1 -1 -1 1 0 0 0; 0 0 0 0 -1 1 0 0 1; 0 0 0 0 1 -1 -1 1 0; 0 0 0 0 0 0 -1 1 1; 0 0 0 0 0 0 1 -1 -1; 0 0 0 0 0 0 0 0 1];


T = 1:1200;                                     
T=T';                                           % column vector of interpolation evaluation points 
                                                % T(end)=1200s is the cell division time 
                                              

%%%%%%%%%%%%%%%%% Parameters and Initial Conditions %%%%%%%%%%%%%%%%%


nA = 6.023e23;                                  % Avagadro's number
vol = 1e-15;                                    % E.coli volume



%%%%%%%%%%%%%%%%%%%%%%%% Deterministic rates

KTl = (23E-9)/60;                               % PP1 transcription rate (M/s)
Kmdeg = 0.462/60;                               % mRNA degradation constant (/s)
KTc = 45/60;                                    % PP1 translation rate (/s)
Kpdeg = 1.15/60;                                % PP1 degradation constant (/s    
K1 = (4.8E5)/60;                                % PP1cyto & TatB-C recognition binding rate (/M.s)
Kr1 = 0.08/60;                                  % PP1B-C unbinding rate (/s)
K2 = (120E6)/(60);                              % Assembly association rate /M/s 
Kr2 = 0.1/60;                                   % PP1export disassociation rate (/s)                                               
K3 = 10;                                        % Export rate(/s)    

%%%%%%%%%%%%%%%%%%%%%%%% Corresponding Stochastic rates
c(1) = KTl*(nA*vol); 
c(2) = Kmdeg; 
c(3) = KTc;
c(4) = Kpdeg;
c(5) = K1/(nA*vol);
c(6) = Kr1;
c(7) = K2/(nA*vol);
c(8) = Kr2;
c(9) = K3;



X = zeros(7,1);                                 % X(1) = mRNA
                                                % X(2) = PP1cyto
                                                % X(3) = TatB-C
                                                % X(4) = PP1B-C
                                                % X(5) = TatAassembly
                                                % X(6) = PP1export
                                                % X(7) = PP1peri
                                                
X(3) = round(TatBC_conc*nA*vol);                % number of TatB-C complexes
X(5) = round(TatAassembly_conc*nA*vol);         % number of TatA assemblies



%%%%%%%%%%%%%%%%% Gillespie's algorithm %%%%%%%%%%%%%%%%%

t = 0;                                           
tfinal = 1200;

count = 1;
tvals(1) = 0;
Xvals(:,1) = X;

while t < tfinal
         a(1) = c(1);
         a(2) = c(2)*X(1);
         a(3) = c(3)*X(1);
         a(4) = c(4)*X(2);
         a(5) = c(5)*X(2)*X(3);
         a(6) = c(6)*X(4);
         a(7) = c(7)*X(4)*X(5);
         a(8) = c(8)*X(6);
         a(9) = c(9)*X(6);

         asum = sum(a);
         b = min(find(rand<cumsum(a/asum)));
         % selects reaction to take place
         tau = log(1/rand)/asum;
         % time for reaction
         X = X + V(:,b);

         count = count + 1;
         t = t + tau;
         tvals(count) = t;
         Xvals(:,count) = X;
end

%%%%%%%%%% Plot data %%%%%%%%%%

Length = length(tvals);
tnew = zeros(1,2*(Length-1));
tnew(1:2:end-1) = tvals(2:end);
tnew(2:2:end) = tvals(2:end);
tnew = [tvals(1),tnew];

tnew=tnew';

PP1cyto_vals = Xvals(2,:);
ynew = zeros(1,2*Length-1);
ynew(1:2:end) = PP1cyto_vals;
ynew(2:2:end-1) = PP1cyto_vals(1:end-1);

ynew=ynew';

PP1peri_vals = Xvals(7,:);
znew = zeros(1,2*Length-1);
znew(1:2:end) = PP1peri_vals;
znew(2:2:end-1) = PP1peri_vals(1:end-1);

znew=znew';

%%%%%%%%%% Interpolation %%%%%%%%%%

PP1cyto(:,j) = interp1q(tnew,ynew,T);
PP1peri(:,j) = interp1q(tnew,znew,T);

end