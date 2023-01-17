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
    k_120_range(i,j)=sens_res(i,j).kappa(120); 
end 
end 

for i=1:sens_run_1
for j=1:sens_run_2
    k_240_range(i,j)=sens_res(i,j).kappa(240); 
end 
end 

fig_k120=figure('DefaultAxesFontSize',16);
surf(k_120_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k120, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k120,'Position');
set(fig_k120,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 15])

fig_k240=figure('DefaultAxesFontSize',16);
surf(k_240_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k240, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k240,'Position');
set(fig_k240,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 30])
set(gcf, 'renderer', 'opengl');