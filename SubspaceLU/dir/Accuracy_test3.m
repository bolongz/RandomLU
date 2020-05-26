%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
%[A,~] = genTestMatrix(500, 500, 1); %slow decay 
%[A,~] = genTestMatrix(500, 500, 1); %decay rapidly
[A,~] = genTestMatrix(500, 500, 3); %S-shape
kk = 100;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2)

powerr = zeros(dim,1);
powerr3 = zeros(dim,1);
powerr4 = zeros(dim,1);
powerr5 = zeros(dim,1);
powerr6 = zeros(dim,1);

powerrfp = zeros(dim,1);
powerr3fp = zeros(dim,1);
powerr4fp = zeros(dim,1);
powerr5fp = zeros(dim,1);
powerr6fp = zeros(dim,1);


for i = 1:20
    powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
    powerr = powerr + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,3, mode);
    powerr3 = powerr3 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,4, mode);
    powerr4 = powerr4 + powerlu_errs;

    powerlu_errs = PowerLU_errors(A,ss,kk,step,5, mode);
    powerr5 = powerr5 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,6, mode);
    powerr6 = powerr6 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,2, mode);
    powerrfp = powerrfp + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,3, mode);
    powerr3fp = powerr3fp + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,4, mode);
    powerr4fp = powerr4fp + powerlu_errs;

    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,5, mode);
    powerr5fp = powerr5fp + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,6, mode);
    powerr6fp = powerr6fp + powerlu_errs;
    
end
%svd_errs = SVD_errors(A, ss, kk, step,mode);

powerr = [20; powerr];
powerr3 = [20; powerr3];
powerr4 = [20; powerr4];
powerr5 = [20; powerr5];
powerr6 = [20; powerr6];

powerrfp = [20; powerrfp];
powerr3fp = [20; powerr3fp];
powerr4fp = [20; powerr4fp];
powerr5fp = [20; powerr5fp];
powerr6fp = [20; powerr6fp];
X = [0, X];

subplot(1,2,1);
%profile report
%h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
h1 = semilogy(X, powerr/20, '--c', 'LineWidth', 1.5, 'MarkerSize', 8);
hold on

h2 = semilogy(X, powerr3/20, '-.g', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, powerr4/20, '-m','LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, powerr5/20, '-.b', 'LineWidth', 1.5, 'MarkerSize', 8);
h5 = semilogy(X, powerr6/20, '-c','LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, powerrfp/20, 'r<', 'LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, powerr3fp/20, 'b>', 'LineWidth', 1.5, 'MarkerSize', 8);
h8 = semilogy(X, powerr4fp/20, 'g^','LineWidth', 1.5, 'MarkerSize', 8);
h9 = semilogy(X, powerr5fp/20, 'm>', 'LineWidth', 1.5, 'MarkerSize', 8);
h10 = semilogy(X, powerr6fp/20, 'c^','LineWidth', 1.5, 'MarkerSize', 8);

hold off
L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1), h10(1)],...
'PowerLU, q = 2','PowerLU, q = 3', 'PowerLU, q = 4', 'PowerLU, q = 5',...
'PowerLU, q = 6',  'PowerLU_FP, q = 2','PowerLU_FP, q = 3', 'PowerLU_FP, q = 4',...
'PowerLU_FP, q = 5',...
'PowerLU_FP, q = 6');
L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
%ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');


%{
mode = 'spec';
powerr = zeros(dim,1);
powerr3 = zeros(dim,1);
powerr4 = zeros(dim,1);
powerr5 = zeros(dim,1);
powerr6 = zeros(dim,1);

powerrfp = zeros(dim,1);
powerr3fp = zeros(dim,1);
powerr4fp = zeros(dim,1);
powerr5fp = zeros(dim,1);
powerr6fp = zeros(dim,1);


for i = 1:20
    powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
    powerr = powerr + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,3, mode);
    powerr3 = powerr3 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,4, mode);
    powerr4 = powerr4 + powerlu_errs;

    powerlu_errs = PowerLU_errors(A,ss,kk,step,5, mode);
    powerr5 = powerr5 + powerlu_errs;
    
    powerlu_errs= PowerLU_errors(A,ss,kk,step,6, mode);
    powerr6 = powerr6 + powerlu_errs;
    
    powerlu_errs = PowerLU_blocked_errors(A,ss,kk,step,2, mode);
    powerrfp = powerrfp + powerlu_errs;
    
    powerlu_errs = PowerLU_blocked_errors(A,ss,kk,step,3, mode);
    powerr3fp = powerr3fp + powerlu_errs;
    
    powerlu_errs = PowerLU_blocked_errors(A,ss,kk,step,4, mode);
    powerr4fp = powerr4fp + powerlu_errs;

    powerlu_errs = PowerLU_blocked_errors(A,ss,kk,step,5, mode);
    powerr5fp = powerr5fp + powerlu_errs;
    
    powerlu_errs = PowerLU_blocked_errors(A,ss,kk,step,6, mode);
    powerr6fp = powerr6fp + powerlu_errs;
    
end
%svd_errs = SVD_errors(A, ss, kk, step,mode);

powerr = [20; powerr];
powerr3 = [20; powerr3];
powerr4 = [20; powerr4];
powerr5 = [20; powerr5];
powerr6 = [20; powerr6];

powerrfp = [20; powerrfp];
powerr3fp = [20; powerr3fp];
powerr4fp = [20; powerr4fp];
powerr5fp = [20; powerr5fp];
powerr6fp = [20; powerr6fp];

subplot(1,2,2);
%profile report
%h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
h1 = semilogy(X, powerr/20, '--c', 'LineWidth', 1.5, 'MarkerSize', 8);
hold on

h2 = semilogy(X, powerr3/20, '-.g', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, powerr4/20, '-m','LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, powerr5/20, '-.b', 'LineWidth', 1.5, 'MarkerSize', 8);
h5 = semilogy(X, powerr6/20, '-c','LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, powerrfp/20, 'r<', 'LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, powerr3fp/20, 'b>', 'LineWidth', 1.5, 'MarkerSize', 8);
h8 = semilogy(X, powerr4fp/20, 'g^','LineWidth', 1.5, 'MarkerSize', 8);
h9 = semilogy(X, powerr5fp/20, 'm>', 'LineWidth', 1.5, 'MarkerSize', 8);
h10 = semilogy(X, powerr6fp/20, 'c^','LineWidth', 1.5, 'MarkerSize', 8);

hold off
%L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1)],'SVD',...
%'PowerLU, q = 2','PowerLU, q = 3', 'PowerLU, q = 4', 'PowerLU, q = 5',...
%'PowerLU, q = 6',  'RandomLU, p = 0', 'RandomLU, p = 1',  'RandomLU, p = 2');
%L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
%ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');
%}