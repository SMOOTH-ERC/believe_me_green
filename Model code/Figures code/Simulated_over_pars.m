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

xmul1=ceil((sens_run_2-1)/5);
n_xticks_mul=xmul1;
roundn=2;
xmul=round(sens_par_range_2(xmul1)/xmul1,roundn);

ymul1=ceil((sens_run_1-1)/5);
n_yticks_mul=ymul1;
roundn=2;
ymul=round(sens_par_range_1(ymul1)/ymul1,roundn);

fig_k120=figure('DefaultAxesFontSize',16);
surf(k_120_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
xticks(1:n_xticks_mul:sens_run_2)
xticklabels((get(gca,'xtick')-1)*xmul)
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
yticks(1:n_yticks_mul:sens_run_1)
yticklabels((get(gca,'ytick')-1)*ymul)
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k120, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k120,'Position');
set(fig_k120,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 15])
%print(gcf, '-dpdf', 'fig_k120.pdf');

fig_k240=figure('DefaultAxesFontSize',16);
surf(k_240_range)
xlabel(sens_par_name_2,'FontSize',24,'Interpreter','latex')
xticks(1:n_xticks_mul:sens_run_2)
xticklabels((get(gca,'xtick')-1)*xmul)
ylabel(sens_par_name_1,'FontSize',24,'Interpreter','latex')
yticks(1:n_yticks_mul:sens_run_1)
yticklabels((get(gca,'ytick')-1)*ymul)
ylim([1 sens_run_1])
xlim([1 sens_run_2])
colormap(winter);
set(fig_k240, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig_k240,'Position');
set(fig_k240,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([350 30])
set(gcf, 'renderer', 'opengl');
%print(gcf, '-dpdf', 'my-figure.pdf');
