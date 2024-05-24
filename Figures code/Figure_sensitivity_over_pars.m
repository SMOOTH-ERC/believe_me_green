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

xmul1=ceil((sens_run_2-1)/5);
n_xticks_mul=xmul1;
roundn=2;
xmul=round(sens_par_range_2(xmul1)/xmul1,roundn);
%xmul=0.99/101; 

ymul1=ceil((sens_run_1-1)/5);
n_yticks_mul=ymul1;
roundn=2;
ymul=round(sens_par_range_1(ymul1)/ymul1,roundn);

fig_k120=figure('DefaultAxesFontSize',16);
surf(k_80_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
xticks(1:n_xticks_mul:sens_run_2)
xticklabels((get(gca,'xtick')-1)*xmul)
%xticklabels({'0.97','0.9738','0.9778','0.9818','0.9858','0.99'})
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
yticks(1:n_yticks_mul:sens_run_1)
yticklabels((get(gca,'ytick')-1)*ymul)
zlabel("$\kappa$",'FontSize',24,'Interpreter','latex','rotation',0)
colormap(winter);
set(fig_k120, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k120,'Position');
set(fig_k120,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([290 20])
%print(gcf, '-dpdf', 'sens_gtax_c_29020_k80.pdf');


fig_k240=figure('DefaultAxesFontSize',16);
surf(k_160_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
ylim([1 sens_run_1])
xlim([1 sens_run_2])
xticks(1:n_xticks_mul:sens_run_2)
xticklabels((get(gca,'xtick')-1)*xmul)
%xticklabels({'0.97','0.9738','0.9778','0.9818','0.9858','0.99'})
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
yticks(1:n_yticks_mul:sens_run_1)
yticklabels((get(gca,'ytick')-1)*ymul)
zlabel("$\kappa$",'FontSize',24,'Interpreter','latex','rotation',0)
colormap(winter);
set(fig_k240, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k240,'Position');
set(fig_k240,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([290 20])
set(gcf, 'renderer', 'opengl');
%print(gcf, '-dpdf', 'sens_gtax_c_29020_k160.pdf');
