
plot(X, qr_times/20, '-gx' , X, eigsvd_times/20, '-m*',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'QR', 'EigSVD');
L.FontSize = 20;
set(gca,'FontSize',18)
xlabel('k', 'FontSize',20,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',20,'FontWeight','bold');
