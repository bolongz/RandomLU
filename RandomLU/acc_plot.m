

figure(3);
h1 = semilogy(X, svd_errs, '-r','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, rsvd_err/20, '--k', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, rsvd_err1/20, 'bo', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, rsvd_err2/20, 'cd','LineWidth', 1.5, 'MarkerSize', 8);

h5 = semilogy(X, rlu_err/20, 'k+','LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, rlu_err1/20, 'bd' ,'LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, rlu_err2/20, 'gp' ,'LineWidth', 1.5, 'MarkerSize', 8);

h8 = semilogy(X, rlu_no_err/20, 'k*','LineWidth', 1.5, 'MarkerSize', 8);
h9 = semilogy(X, rlu_no_err1/20, 'rd' ,'LineWidth', 1.5, 'MarkerSize', 8);
h10 = semilogy(X, rlu_no_err2/20, 'g^' ,'LineWidth', 1.5, 'MarkerSize', 8);

h11 = semilogy(X, powerlu_err2/20, 'c+', 'LineWidth', 1.5, 'MarkerSize', 8);
h12 = semilogy(X, powerlu_err4/20, 'gs', 'LineWidth', 1.5, 'MarkerSize', 8);
h13 = semilogy(X, powerlu_err6/20, 'mh','LineWidth', 1.5, 'MarkerSize', 8);


h14 = semilogy(X, powerlu_b_err2/20, 'g<', 'LineWidth', 1.5, 'MarkerSize', 8);
h15 = semilogy(X, powerlu_b_err4/20, 'k>', 'LineWidth', 1.5, 'MarkerSize', 8);
h16 = semilogy(X, powerlu_b_err6/20, 'b^','LineWidth', 1.5, 'MarkerSize', 8);


h17 = semilogy(X, powerlu_eb_err2/20, 'r+', 'LineWidth', 1.5, 'MarkerSize', 8);
h18 = semilogy(X, powerlu_eb_err4/20, 'ks', 'LineWidth', 1.5, 'MarkerSize', 8);
h19 = semilogy(X, powerlu_eb_err6/20, 'bp','LineWidth', 1.5, 'MarkerSize', 8);
hold off
L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1) ...
    h10(1), h11(1), h12(1), h13(1), h14(1), h15(1), h16(1), h17(1), h18(1), h19(1)],'SVD',...
'RandSVD, p = 0','RandSVD, p = 1', 'RandSVD, p = 2', 'RandLU, p = 0',...
'RandLU, p = 1',  'RandLU, p = 2', ...
'RandLU\_N\_Orth, p = 0',...
'RandLU\_N\_Orth, p = 1',  'RandLU\_N\_Orth, p = 2', ...
'PowerLU, v = 2',  'PowerLU, v = 4', ...
 'PowerLU, v = 6',  'PowerLU\_b, v = 2', 'PowerLU\_b, v = 4', 'PowerLU\_b, v = 6',...
'PowerLU\_eb, v = 2', 'PowerLU\_eb, v = 4', 'PowerLU\_eb, v = 6');
L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('l', 'FontSize',15,'FontWeight','bold');
%ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');

save('acc3.mat');
