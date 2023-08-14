%% Creation of 3D figures for sensitivity of green capital share (kappa) over 2 parameters 
% it first requires to run a sensitivity analysis (file run.m) over two
% parameters ("sens_par_name_1" and "sens_par_name_2")

% it produces two 3D figures, one for each simulation step
% kappa is evaluated at two simulations steps
% step 120 which corresponds to year 2050
% step 240 which corresponds to year 2080

% e.g. Figure 5 in the working paper "Believe me when I say green".

set(groot,'defaultAxesTickLabelInterpreter','latex');

for i=1:sens_run_1
for j=1:sens_run_2
    k_80_range(i,j)=sens_res(i,j).kappa(80); 
end 
end 

for i=1:sens_run_1
for j=1:sens_run_2
    k_160_range(i,j)=sens_res(i,j).kappa(160); 
end 
end 

fig_k80=figure('DefaultAxesFontSize',16);
surf(k_80_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k80, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k80,'Position');
set(fig_k80,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 15])

fig_k160=figure('DefaultAxesFontSize',16);
surf(k_160_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k160, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k160,'Position');
set(fig_k160,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 30])
set(gcf, 'renderer', 'opengl');