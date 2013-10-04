%%%%%%%% v7_ssa_PP1_TATproduction_export.m
%%%%%% Craig Johnston
%
%%%% The program, v7_ssa_PP1_TATproduction_export, calls the function, 
% ssa_PP1_TATproduction_export, to plot the Stochastic mean resulting from
% the selected number of realisations of the PP1cyto & PP1peri production 
% system
%
% The value of TatAassembly_number is fixed and the value of TatBC_number
% is looped over the range [15,45] for the selected number of realisations.
% A selection of plots are output in the figures to visualise
% the effect on PP1 production and export of increasing the number of
% TatBC.
%
% The program also uses the plot function v7_ssa_plot_PP1_TATproduction_export.

clear
close all


realisation_number = input('Enter the number of realisations ');


%%%%%%%%%%%%%%%%% Parameters & Initial Conditions %%%%%%%%%%%%%%%%%

nA = 6.023e23;                                % Avagadro's number
vol = 1e-15;                                  % E.coli volume
     
TatAassembly_number = 30;                    % TatAassembly is an assembly of 20 TatA proteins
TatAassembly_conc = (TatAassembly_number/nA) / vol; 

% set up matrices to store results
PP1cyto=zeros(1200,realisation_number);       % (cell division time, number of realisations)
PP1peri=zeros(1200,realisation_number);
var_PP1cyto = zeros(286,1);
var_PP1peri = zeros(286,1);
number_cells = zeros(286,1);
mass_cells = zeros(286,1);

            
number_TatBC= 15:300;
number_TatBC=number_TatBC';                   % column vector of TatAassembly numbers


rand('state',100)


for k=15:300;
    
            l=k;
            
            TatBC_number = k;                 % TatBC is a complex of TatB and TatC proteins
            TatBC_conc = (TatBC_number/nA) / vol;

            for i=1:realisation_number
                
                        j=i;
                        [PP1cyto,PP1peri,T,tnew,ynew,znew] = ssa_PP1_TATproduction_export(TatAassembly_conc,TatBC_conc,j,PP1cyto,PP1peri);         
            end
            
            % calculates Stochastic mean and stores the mean end value for each TatBC_number
            PP1cyto_Stochasticmean = mean(PP1cyto,2);
            var_PP1cyto(l-14,1) =  mean(PP1cyto(1200,:));

            PP1peri_Stochasticmean = mean(PP1peri,2);
            var_PP1peri(l-14,1) =  mean(PP1peri(1200,:));

            %%%%%%%%%% Plots %%%%%%%%%%
            
            % figure(1) - PP1cyto vs Time
            
            figure(1);
                    hold on
                    
                    if l==15;
                            plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                    end
                    
                    if l==30;
                            plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                    end

                    remainder = rem(l,50);
                    
                    % plot result for each TatBC_number multiple of 50 
                    if remainder==0 
                            v7_ssa_plot_PP1_TATproduction_export(l,T,PP1cyto_Stochasticmean)   
                    end  

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Cytoplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    

            % figure(2) - PP1peri vs Time

            figure(2);
                    hold on
                    
                    if l==15;
                            plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                    end
                    
                    if l==30;
                            plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                    end

                    if remainder==0 
                            v7_ssa_plot_PP1_TATproduction_export(l,T,PP1peri_Stochasticmean)   
                    end  

                    xlabel('Time (s)','FontSize',14)
                    ylabel('Number of PP1 in Periplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    
           % figure(3) - Combined subplot
           
           figure(3)
                   subplot(1,2,1)
                                hold on
                    
                                if l==15;
                                        plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                                end

                                if l==30;
                                        plot(T,PP1cyto_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                                end

                                remainder = rem(l,50);

                                % plot result for each TatBC_number multiple of 50 
                                if remainder==0 
                                        v7_ssa_plot_PP1_TATproduction_export(l,T,PP1cyto_Stochasticmean)   
                                end  

                                xlabel('Time (s)','FontSize',14)
                                ylabel('Number of PP1 in Cytoplasm','FontSize',14)
                                set(gca,'FontWeight','Bold','FontSize',12)
           
                   subplot(1,2,2)
                                hold on
                    
                                if l==15;
                                        plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.224,0.686,0.812],'LineSmoothing','on');
                                end

                                if l==30;
                                        plot(T,PP1peri_Stochasticmean,'LineWidth', 1.5,'Color', [0.922,0.235,0.545],'LineSmoothing','on');
                                end

                                if remainder==0 
                                        v7_ssa_plot_PP1_TATproduction_export(l,T,PP1peri_Stochasticmean)   
                                end  

                                xlabel('Time (s)','FontSize',14)
                                ylabel('Number of PP1 in Periplasm','FontSize',14)
                                set(gca,'FontWeight','Bold','FontSize',12)
                   
    
end

hleg = legend('15','30','50','100','150','200','250','300');
htitle = get(hleg,'Title');
set(htitle,'String','Number of TatB-C Complexes','FontWeight','Bold','FontSize',12)

figure(2);
hleg = legend('15','30','50','100','150','200','250','300');
htitle = get(hleg,'Title');
set(htitle,'String','Number of TatB-C Complexes','FontWeight','Bold','FontSize',12)


%%%%%%%%%% Plots %%%%%%%%%%

% figure(4) - TatBC vs PP1peri

figure(4);
        hold on
        
        plot(number_TatBC, var_PP1peri,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on');

        xlabel('Number of TatB-C Complexes','FontSize',14)
        ylabel('Number of PP1 in Periplasm','FontSize',14)
        set(gca,'FontWeight','Bold','FontSize',12)
        grid on

% figure(5) - TatBC vs Mass of Cells

figure(5);
        hold on

        for n=1:286
                number_cells(n,1)= 1.21E15/var_PP1peri(n,1);
                mass_cells(n,1) = number_cells(n,1)*9.5e-13;
        end

        plot(number_TatBC,mass_cells,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on')

        xlabel('Number of TatB-C Complexes','FontSize',14)
        ylabel('Mass of Cells (g)','FontSize',14)
        set(gca,'FontWeight','Bold','FontSize',12)
        grid on
        
% figure(6) - Combined subplot    

figure(6)
        subplot(1,2,1)
                    hold on

                    plot(number_TatBC, var_PP1peri,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on');

                    xlabel('Number of TatB-C Complexes','FontSize',14)
                    ylabel('Number of PP1 in Periplasm','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    grid on
                    

        subplot(1,2,2)
                    hold on

                    plot(number_TatBC,mass_cells,'LineWidth', 1.5,'Color', [0,0.329,0.651],'LineSmoothing','on')

                    xlabel('Number of TatB-C Complexes','FontSize',14)
                    ylabel('Mass of Cells (g)','FontSize',14)
                    set(gca,'FontWeight','Bold','FontSize',12)
                    grid on
        


