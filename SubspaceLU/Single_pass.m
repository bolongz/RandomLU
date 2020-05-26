%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
%[A,~] = genTestMatrix(2000, 2000, 1); %slow decay
clear;
[A,~] = genTestMatrix(2000, 2000, 1); %decay rapidly
%[A,~] = genTestMatrix(500, 500, 3); %S-shape
kk = 100;
ss = 10;
step = 10;
X = [ss:step:kk];

mode = 'fro';

dim = size(X,2);


%powerr = zeros(dim, 1);
%powerr2 = zeros(dim, 1);
powerrsp = zeros(dim,1);
singlepass2011err = zeros(dim,1);
randqbsinglepasserr = zeros(dim,1);
for i = 1:20
    %powerlu_errs = PowerLU_errors(A,ss,kk,step,1, mode);
    %powerr = powerr + powerlu_errs;
  %  powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
 %   powerr2 = powerr2 + powerlu_errs;
    powerlusp_errs = PowerLU_singlepass_errors(A,ss,kk,step, mode);
    powerrsp = powerrsp + powerlusp_errs;
    sp2011errs = singlepass2011_errors(A, ss, kk,step, mode);
    singlepass2011err = singlepass2011err + sp2011errs;
    randqberr = randQB_siglepass_errors(A, ss, kk,step, mode);
    randqbsinglepasserr = randqbsinglepasserr + randqberr;
 
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);
%powerr = [20; powerr];
%powerr2 = [20; powerr2];
powerrsp = [20; powerrsp];
singlepass2011err = [20; singlepass2011err];
randqbsinglepasserr = [20; randqbsinglepasserr];
svd_errs = [1; svd_errs];
X = [0, X];

%{
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
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Error', 'FontSize',15,'FontWeight','bold');
%}

[A,~] = genTestMatrix(2000, 2000, 2); %decay rapidly


mode = 'fro';
%powerr = zeros(dim, 1);
%powerr2 = zeros(dim, 1);
powerrspf = zeros(dim,1);
singlepass2011errf = zeros(dim,1);
randqbsinglepasserrf = zeros(dim,1);
for i = 1:20
    %powerlu_errs = PowerLU_errors(A,ss,kk,step,1, mode);
    %powerr = powerr + powerlu_errs;
    %powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
    %powerr2 = powerr2 + powerlu_errs;
    powerlusp_errs = PowerLU_singlepass_errors(A,ss,kk,step, mode);
    powerrspf = powerrspf + powerlusp_errs;
    sp2011errs = singlepass2011_errors(A, ss, kk,step, mode);
    singlepass2011errf = singlepass2011errf + sp2011errs;
    randqberr = randQB_siglepass_errors(A, ss, kk,step, mode);
    randqbsinglepasserrf = randqbsinglepasserrf + randqberr;
    
end
svd_errsf = SVD_errors(A, ss, kk, step,mode);
%powerr = [20; powerr];
%powerr2 = [20; powerr2];
powerrspf = [20; powerrspf];
singlepass2011errf = [20; singlepass2011errf];
randqbsinglepasserrf = [20; randqbsinglepasserrf];

svd_errsf = [1; svd_errsf];
%{
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
%}
save('single.mat');
