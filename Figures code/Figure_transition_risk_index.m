%% Creation of figures showing the shape of the transition risk index (pi_pot)

% it creates a 3D figuree showing the transition risk index as a function
% of two parameters ("g_tax" and "1-kappa")

% e.g. Figure A2 in the working paper "Believe me when I say green".

set(groot,'defaultAxesTickLabelInterpreter','latex');

rangeZ=2; 
i=1;
for Z=rangeZ
%subplot(1,2,i)
[X,Y] = meshgrid(0:0.01:1,0:0.1:10);
Z = 1 - 1./(1 + Z.*(1-X).*Y);
i=i+1;
end
fig=figure('DefaultAxesFontSize',16);
surf(X,Y,Z); 
xlabel('$\kappa$','FontSize',24,'Interpreter','latex')
ylabel('$\bar{\tau}$','FontSize',24,'Interpreter','latex')
colormap(winter)
set(fig, 'units', 'centimeters', 'pos', [0 0 20 15])
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','centimeters','PaperSize',[pos(3), pos(4)])
view([15 30])
set(gcf, 'PaperPositionMode', 'manual');
set(gcf, 'renderer', 'opengl');
%print(gcf, '-dpdf', 'my-figure.pdf');
