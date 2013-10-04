%%%%%%%% v3_ssa_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v3_ssa_PP1_TATproduction_export, is an extension to the 
% program v1_ssa_PP1_TATproduction_export. The output is the minimum mass
% of cells, required in the MOP experiment, to mop up the input microcystin
% level.

v1_ssa_PP1_TATproduction_export

nA = 6.023e23;                                % Avagadro's number

MC_conc = 0.1;                                % Microcystin concentration (g/l)
MC_molarmass = 995.17;                        % Microcystin molar mass (g)
MC_vol = input('Enter the Microcystin Solution Volume in litres ');

MC_mass = MC_conc * MC_vol;
MC_number = (MC_mass/MC_molarmass)*nA;


number_cells = MC_number/PP1peri_Stochasticmean(end);
mass_cells = number_cells*9.5e-13;

% displays the number of cells required
disp('The mass of E.coli cells required to mop up the microcystin in grams is')
mass_cells


