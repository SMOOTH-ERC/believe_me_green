%% Creation of figures showing the simulation unfolding over steps for multiple values of a single parameter
% it first requires to run the model (file run.m)
% it creates a series of figures showing a selection of variables over
% simulation steps for different values of parameter "sens_par_name_1" as
% defined in file "run.m"

% e.g. Fig. 8 in the working paper "Believe me when I say green".


end_time=T-R;
transient=4; 

set(groot,'defaultAxesTickLabelInterpreter','latex');
j=1; 

fig1=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on 
    plot(sens_res(i,j).tax_target,'LineWidth',0.75)
    xline(120,'LineWidth',1)
    annotation('textbox', [0.42, 0.7, 0.35, 0.1], 'String', "Carbon price in 2050: 390 \$/tCO2",'Interpreter','latex','FontSize',10,'FontWeight','Bold','EdgeColor','none');
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
    
end
set(fig1, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig1,'Position');
set(fig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'tax_target_vc.pdf');

fig2=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).tax,'LineWidth',0.75) 
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
end
set(fig2, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig2,'Position');
set(fig2,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'tax_vc.pdf');

fig3=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).n,'LineWidth',0.75)
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
end
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(fig3, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig3,'Position');
set(fig3,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'n_vc.pdf');


fig4=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).chi_agg,'LineWidth',0.75) 
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
end
set(fig4, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig4,'Position');
set(fig4,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'chi_vc.pdf');

fig5=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).kappa,'LineWidth',0.75)
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
end
set(fig5, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig5,'Position');
set(fig5,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'kappa_vc.pdf');

fig6=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).pi_pot,'LineWidth',0.75) 
    xlim([transient end_time])
    xticks([transient,80,160,240,end_time])
    xticklabels({'2020','2040','2060','2080','2100'})
end
set(fig6, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig6,'Position');
set(fig6,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'PaperPosition', [0 0 12 5]);
set(gcf, 'renderer', 'painters');
print(gcf, '-dpdf', 'tr_vc.pdf');

%sens_par_name_1 = 'c';
%lh=legend(strcat(sens_par_name_1, '=',num2str(sens_par_range_1')),'location','south','Orientation','horizontal','FontSize',12,'Interpreter','latex')
