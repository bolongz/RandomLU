
plot(X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'Randomized LU', 'RandSVD');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');
