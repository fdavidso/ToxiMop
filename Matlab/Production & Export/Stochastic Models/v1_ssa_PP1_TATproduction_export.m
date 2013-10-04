%%%%%%%% v1_ssa_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v1_ssa_PP1_TATproduction_export, calls the function, 
% ssa_PP1_TATproduction_export, to plot the selected number of Stochastic 
% realisations and the resulting Stochastic mean of the production and export
% of PP1cyto & PP1peri.
% 
% The values of TatAassembly_number and TatBC_number are fixed and the
% realisation_number controls the number of realisations output.

clear
close all


realisation_number = input('Enter the number of realisations ');


%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
            
TatAassembly_number = 30;                    % TatAassembly is an assembly of 20 TatA proteins
TatBC_number = 15;                            % TatBC is a complex of TatB and TatC proteins

TatAassembly_conc = (TatAassembly_number/nA) / vol;               
TatBC_conc = (TatBC_number/nA) / vol; 


% set up matrices to store results
% (cell division time, number of realisations)
PP1cyto=zeros(1200,realisation_number);
PP1peri=zeros(1200,realisation_number);
           
rand('state',100)
            

for i=1:realisation_number
    
            j=i;
            
            [PP1cyto,PP1peri,T,tnew,ynew,znew] = ssa_PP1_TATproduction_export(TatAassembly_conc,TatBC_conc,j,PP1cyto,PP1peri);
            
            %%%%%%%%%% Plots %%%%%%%%%%
            
            % figure(1) - PP1cyto vs Time
            
            figure(1);
                    hold on

                    plot(tnew,ynew,'Color', [0.808, 0.808, 0.808]);

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Cytoplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    grid on
                    axis([0 1200, 0 ,2000])
                    
           % figure(2) - PP1peri vs Time    

           figure(2);
                    hold on

                    plot(tnew,znew,'Color', [0.808, 0.808, 0.808]);

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Periplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    grid on
                    axis([0 1200, 0 ,250])
                    
         % figure(3) - Combined subplot            
         figure(3);
                  subplot(1,2,1)
                        hold on

                        plot(tnew,ynew,'Color', [0.808, 0.808, 0.808]);

                        xlabel('Time (s)','FontSize',14)
                        ylabel('Number of PP1 in Cytoplasm','FontSize',14)
                        set(gca,'FontWeight','Bold','FontSize',12)
                        grid on
                        axis([0 1200, 0 ,2000])
                        
                   subplot(1,2,2)
                        hold on

                        plot(tnew,znew,'Color', [0.808, 0.808, 0.808]);

                        xlabel('Time (s)','FontSize',14)
                        ylabel('Number of PP1 in Periplasm','FontSize',14)
                        set(gca,'FontWeight','Bold','FontSize',12)
                        grid on
                        axis([0 1200, 0 ,250])
                        

end

% calculates Stochastic mean
PP1cyto_Stochasticmean = mean(PP1cyto,2);
PP1peri_Stochasticmean = mean(PP1peri,2);

% displays the number of PP1 in the cytoplasm & periplasm 
disp('The number of PP1 in the cytoplasm is')
round(PP1cyto_Stochasticmean(end))

disp('The number of PP1 in the periplasm is')
round(PP1peri_Stochasticmean(end))


%%%%%%%%%% Plots %%%%%%%%%%

figure(1);
        plot(T,PP1cyto_Stochasticmean,'LineWidth', 2,'LineSmoothing','on','Color', [1,0.525,0.365]);

figure(2);
        plot(T,PP1peri_Stochasticmean,'LineWidth',2,'LineSmoothing','on','Color', [0.224,0.686,0.812]);
        
 figure(3);
        subplot(1,2,1)
                plot(T,PP1cyto_Stochasticmean,'LineWidth', 2,'LineSmoothing','on','Color', [1,0.525,0.365]);
        subplot(1,2,2) 
                plot(T,PP1peri_Stochasticmean,'LineWidth',2,'LineSmoothing','on','Color', [0.224,0.686,0.812]);




    
           
    

