%profile report
subplot(1,2,1)
h1 = semilogy(X, svd_errs, '-r','LineWidth', 1.5, 'MarkerSize', 8);
hold on
%h2 = semilogy(X, powerr/20, 'bo', 'LineWidth', 1.5, 'MarkerSize', 8);
%h3 = semilogy(X, powerr2/20, 'kp', 'LineWidth', 1.5, 'MarkerSize', 8);
h2 = semilogy(X, powerrsp/20, 'cd', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, singlepass2011err/20, 'g^', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, randqbsinglepasserr/20, 'b>', 'LineWidth', 1.5, 'MarkerSize', 8);

hold off
L = legend([h1(1), h2(1), h3(1), h4(1)],'SVD','SinglePass', 'SinglePass2011', 'randQB\_FP');
L.FontSize = 20;
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Error', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
%profile report
h1 = semilogy(X, svd_errsf, '-r','LineWidth', 1.5, 'MarkerSize', 8);
hold on
%h2 = semilogy(X, powerr/20, 'bo', 'LineWidth', 1.5, 'MarkerSize', 8);
%h3 = semilogy(X, powerr2/20, 'kp', 'LineWidth', 1.5, 'MarkerSize', 8);
h2 = semilogy(X, powerrspf/20, 'cd', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, singlepass2011errf/20, 'g^', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, randqbsinglepasserrf/20, 'b>', 'LineWidth', 1.5, 'MarkerSize', 8);

hold off
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Error', 'FontSize',15,'FontWeight','bold');
