%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
%[A,~] = genTestMatrix(2000, 2000, 1); %slow decay 
[A,~] = genTestMatrix(500, 500, 2); %decay rapidly
%[A,~] = genTestMatrix(500, 500, 3); %S-shape
kk = 100;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2);

powerr = zeros(dim,1);
singlepass2011err = zeros(dim,1);
randqbsinglepasserr = zeros(dim,1);
for i = 1:20
    [powerlusp_errs, ~] = PowerRandLU_singlepass_errors(A,ss,kk,step, mode);
    powerr = powerr + powerlusp_errs;
    sp2011errs = singlepass2011_errors(A, ss, kk,step, mode);
    singlepass2011err = singlepass2011err + sp2011errs;
    randqberr = randQB_siglepass_errors(A, ss, kk,step, mode);
    randqbsinglepasserr = randqbsinglepasserr + randqberr;
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

powerr = [20; powerr];
singlepass2011err = [20; singlepass2011err];
randqbsinglepasserr = [20; randqbsinglepasserr];
svd_errs = [1; svd_errs];
X = [0, X];

%profile report
subplot(1,2,1)
h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, powerr/20, '--c<', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, singlepass2011err/20, '-.go', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, randqbsinglepasserr/20, '-.b^', 'LineWidth', 1.5, 'MarkerSize', 8);

hold off
L = legend([h1(1), h2(1), h3(1), h4(1)],'SVD',...
'SinglePass', 'SinglePass2011', 'randQB\_FP');
L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');



mode = 'spec';
powerr = zeros(dim,1);
singlepass2011err = zeros(dim,1);
randqbsinglepasserr = zeros(dim,1);
for i = 1:20
    [powerlusp_errs, ~] = PowerRandLU_singlepass_errors(A,ss,kk,step, mode);
    powerr = powerr + powerlusp_errs;
    sp2011errs = singlepass2011_errors(A, ss, kk,step, mode);
    singlepass2011err = singlepass2011err + sp2011errs;
    randqberr = randQB_siglepass_errors(A, ss, kk,step, mode);
    randqbsinglepasserr = randqbsinglepasserr + randqberr;
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

powerr = [20; powerr];
singlepass2011err = [20; singlepass2011err];
randqbsinglepasserr = [20; randqbsinglepasserr];

svd_errs = [1; svd_errs];

subplot(1,2,2);
%profile report
h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, powerr/20, '--c<', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, singlepass2011err/20, '-.go', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, randqbsinglepasserr/20, '-.b^', 'LineWidth', 1.5, 'MarkerSize', 8);

hold off
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
