%% Creation of figures showing the simulation unfolding over steps for multiple values of a single parameter
% it first requires to run the model (file run.m)
% it creates a series of figures showing a selection of variables over
% simulation steps for different values of parameter "sens_par_name_1" as
% defined in file "run.m"

% e.g. Fig. 8 in the working paper "Believe me when I say green".


end_time=160; %T-R;
transient=4; 

set(groot,'defaultAxesTickLabelInterpreter','latex');
j=1; 

fig1=figure('DefaultAxesFontSize',16);
    plot(sens_res(1,1).tax_target,'LineWidth',1)
xline(120+transient,'LineWidth',1)
annotation('textbox', [0.39, 0.7, 0.35, 0.1], 'String', "Carbon price in 2050: 590 \$/tCO2",'Interpreter','latex','FontSize',10,'FontWeight','Bold','EdgeColor','none');
xlim([transient end_time + transient])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})

set(fig1, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig1,'Position');
set(fig1,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf,'-bestfit', '-dpdf', 'tax_target_ltf.pdf');

fig2=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).g_tax_actual,'LineWidth',0.75)%, title(title_tax,'Interpreter','latex');
    yline(g_tax,'LineWidth',0.75)
xlim([transient end_time + transient])
ylim([-0.05 0.05])
%ylim([-0.17 g_tax+0.005])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})
       yticks([-0.05 0 g_tax])
    yticklabels({'-0.05','0',g_tax})
end
set(fig2, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig2,'Position');
set(fig2,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-bestfit','-dpdf', 'tax_ltf.pdf');

fig3=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).n,'LineWidth',0.75)
xlim([transient end_time + transient])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})
end
set(groot,'defaultAxesTickLabelInterpreter','latex');
set(fig3, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig3,'Position');
set(fig3,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf,'-bestfit', '-dpdf', 'n_ltf.pdf');


fig4=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).chi_agg,'LineWidth',0.75) 
xlim([transient end_time + transient])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})
end
set(fig4, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig4,'Position');
set(fig4,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf,'-bestfit', '-dpdf', 'chi_ltf.pdf');

fig5=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).kappa,'LineWidth',0.75)
xlim([transient end_time + transient])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})
end
set(fig5, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig5,'Position');
set(fig5,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'renderer', 'painters');
print(gcf, '-bestfit','-dpdf', 'kappa_ltf.pdf');

fig6=figure('DefaultAxesFontSize',16);
for i=1:sens_run_1
    hold on
    plot(sens_res(i,j).pi_pot,'LineWidth',0.75) 
xlim([transient end_time + transient])
    xticks([transient:40:end_time+transient])
    xticklabels({'2020','2030','2040','2050','2060'})
end
set(fig6, 'units', 'centimeters', 'pos', [0 0 12 5])
pos = get(fig6,'Position');
set(fig6,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
set(gcf, 'PaperPosition', [0 0 12 5]);
set(gcf, 'renderer', 'painters');
print(gcf,'-bestfit', '-dpdf', 'tr_ltf.pdf');

%sens_par_name_1 = 'c';
%lh=legend(strcat(sens_par_name_1, '=',num2str(sens_par_range_1')),'location','south','Orientation','horizontal','FontSize',12,'Interpreter','latex')
