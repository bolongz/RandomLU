%{

h1 = semilogy(X, svd_errs, '-r','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, rsvd_err/20, '--k', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, rsvd_err1/20, 'bo', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, rsvd_err2/20, 'cd','LineWidth', 1.5, 'MarkerSize', 8);

h5 = semilogy(X, rlu_err/20, 'k+','LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, rlu_err1/20, 'bd' ,'LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, rlu_err2/20, 'gp' ,'LineWidth', 1.5, 'MarkerSize', 8);

h8 = semilogy(X, subspacelu_err2/20, 'c+', 'LineWidth', 1.5, 'MarkerSize', 8);
h9 = semilogy(X, subspacelu_err4/20, 'gs', 'LineWidth', 1.5, 'MarkerSize', 8);
h10 = semilogy(X, subspacelu_err6/20, 'mh','LineWidth', 1.5, 'MarkerSize', 8);
%}

h1 = semilogy(X, svd_errs, '-r','LineWidth', 1.0, 'MarkerSize', 8);
hold on
h2 = semilogy(X, rsvd_err1, '-.bo', 'LineWidth', 1.0, 'MarkerSize', 8);

h3 = semilogy(X, rlu_err1, '--bd' ,'LineWidth', 1.0, 'MarkerSize', 8);

h4 = semilogy(X, subspacelu_err4, '--gs', 'LineWidth', 1.0, 'MarkerSize', 8);

hold off
%L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1) ...
%    h10(1)],'SVD',...
%'RandSVD, p = 0','RandSVD, p = 1', 'RandSVD, p = 2', 'RandLU, p = 0',...
%'RandLU, p = 1',  'RandLU, p = 2', ...
%'SubspaceLU, p = 0',  'SubspaceLU, p = 1', ...
% 'SubspaceLU, p = 2');
L = legend([h1(1), h2(1), h3(1), h4(1)],'SVD',...
'RandSVD', 'RandLU', 'SubspaceLU');


L.FontSize = 20;
set(gca,'FontSize',18)
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('l', 'FontSize',20,'FontWeight','bold');
%ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
ylabel('Relative Forbenius Error', 'FontSize',20,'FontWeight','bold');