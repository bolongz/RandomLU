%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
%[A,~] = genTestMatrix(500, 500, 1); %slow decay 
%[A,~] = genTestMatrix(500, 500, 2); %decay rapidly
[A,~] = genTestMatrix(500, 500, 3); %S-shape
kk = 100;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2)

%powerr = zeros(dim,1);
powerlu_err2 = zeros(dim,1);
powerlu_err4 = zeros(dim,1);
powerlu_err6 = zeros(dim,1);

powerlu_b_err2 = zeros(dim,1);
powerlu_b_err4 = zeros(dim,1);
powerlu_b_err6 = zeros(dim,1);


rlu_err = zeros(dim,1);
rlu_er1 = zeros(dim,1);
rlu_err2 = zeros(dim,1);

rsvd_err = zeros(dim,1);
rsvd_er1 = zeros(dim,1);
rsvd_err2 = zeros(dim,1);

svderr = zeros(dim,1);
for i = 1:20
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
    powerlu_err2 = powerlu_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,3, mode);
    powerlu_err4 = powerlu_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,4, mode);
    powerlu_err6 = powerlu_err6 + powerlu_errs;

   
    RandLU_errs = RandLU_errors( A,ss,kk,step, 0, mode);
    rlu_err = rlu_err + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 1, mode);
    rlu_err1 = rlu_err1 + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 2, mode);
    rlu_err2 = rlu_err2 + RandLU_errs;
    
    
    randsvd_errs = randSVD_errors( A,ss,kk,step, 0, mode);
    rsvd_err = rsvd_err + RandLU_errs;
    
    randsvd_errs = randSVD_errors( A,ss,kk,step, 1, mode);
    rsvd_err1 = rsvd_err1 + RandLU_errs;
    
    RandLU_errs  = RandLU_errors( A,ss,kk,step, 2, mode);
    rsvd_err2 = rsvd_err2 + RandLU_errs;  
    
     powerlu_errs = PowerLU_b_errors(A,ss,kk,step,2, mode);
    powerlu_b_err2 = powerlu_b_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_b_errors(A,ss,kk,step,3, mode);
    powerlu_b_err4 = powerlu_b_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_b_errors(A,ss,kk,step,4, mode);
    powerlu_b_err6 = powerlu_b_err6 + powerlu_errs;

    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,2, mode);
    powerlu_eb_err2 = powerlu_eb_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,3, mode);
    powerlu_eb_err4 = powerlu_eb_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,4, mode);
    powerlu_eb_err6 = powerlu_eb_err6 + powerlu_errs;
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

power_err2 = [20; power_err2];
power_err4 = [20; power_err4];
power_err6 = [20; power_err6];

rlu_err = [20; rlu_err];
rlu_err1 = [20; rlu_err1];
rlu_err2 = [20; rlu_err2];

svd_errs = [1; svd_errs];
X = [0, X];

%profile report
subplot(1,2,1)
h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, power_err2/20, 'c<', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, power_err4/20, 'g>', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, power_err6/20, 'm^','LineWidth', 1.5, 'MarkerSize', 8);

h5 = semilogy(X, rlu_err/20, '-.k*','LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, rlu_err1/20, '--bo' ,'LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, rlu_err2/20, '--go' ,'LineWidth', 1.5, 'MarkerSize', 8);

hold off
L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1)],'SVD',...
'PowerLU, q = 2','PowerLU, q = 3', 'PowerLU, q = 4', 'PowerLU, q = 5',...
'PowerLU, q = 6',  'RandomLU, p = 0', 'RandomLU, p = 1',  'RandomLU, p = 2');
L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
%ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');



mode = 'spec';
powerr = zeros(dim,1);
powerr2 = zeros(dim,1);
powerr4 = zeros(dim,1);
powerr5 = zeros(dim,1);
powerr6 = zeros(dim,1);
rluerr = zeros(dim,1);
rluerr1 = zeros(dim,1);
rlu_err2 = zeros(dim,1);
svderr = zeros(dim,1);

for i = 1:20
    [powerlu_errs, ~] = PowerLU_errors(A,ss,kk,step,2, mode);
    powerr = powerr + powerlu_errs;
    
    [powerlu_errs, ~] = PowerLU_errors(A,ss,kk,step,3, mode);
    powerr2 = powerr2 + powerlu_errs;
    
    [powerlu_errs, ~] = PowerLU_errors(A,ss,kk,step,4, mode);
    powerr4 = powerr4 + powerlu_errs;

    [powerlu_errs, ~] = PowerLU_errors(A,ss,kk,step,5, mode);
    powerr5 = powerr5 + powerlu_errs;
    
    [powerlu_errs, ~] = PowerLU_errors(A,ss,kk,step,6, mode);
    powerr6 = powerr6 + powerlu_errs;
    
    [RandLU_errs, ~] = RandLU_errors( A,ss,kk,step, 0, mode);
    rluerr = rluerr + RandLU_errs;
    
    [RandLU_errs, ~] = RandLU_errors( A,ss,kk,step, 1, mode);
    rluerr1 = rluerr1 + RandLU_errs;
    
    [RandLU_errs, ~] = RandLU_errors( A,ss,kk,step, 2, mode);
    rlu_err2 = rlu_err2 + RandLU_errs;   
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

powerr = [20; powerr];
powerr2 = [20; powerr2];
powerr4 = [20; powerr4];
powerr5 = [20; powerr5];
powerr6 = [20; powerr6];
rluerr = [20; rluerr];
rluerr1 = [20; rluerr1];
rlu_err2 = [20; rlu_err2];
svd_errs = [1; svd_errs];

subplot(1,2,2);
%profile report
h1 = semilogy(X, svd_errs, '-rx','LineWidth', 1.5, 'MarkerSize', 8);
hold on
h2 = semilogy(X, powerr/20, '--c<', 'LineWidth', 1.5, 'MarkerSize', 8);
h3 = semilogy(X, powerr2/20, '-.g>', 'LineWidth', 1.5, 'MarkerSize', 8);
h4 = semilogy(X, powerr4/20, '-m^','LineWidth', 1.5, 'MarkerSize', 8);
h5 = semilogy(X, powerr5/20, '-.b>', 'LineWidth', 1.5, 'MarkerSize', 8);
h6 = semilogy(X, powerr6/20, '-c^','LineWidth', 1.5, 'MarkerSize', 8);
h7 = semilogy(X, rluerr/20, '-.k*','LineWidth', 1.5, 'MarkerSize', 8);
h8 = semilogy(X, rluerr1/20, '--bo' ,'LineWidth', 1.5, 'MarkerSize', 8);
h9 = semilogy(X, rlu_err2/20, '--go' ,'LineWidth', 1.5, 'MarkerSize', 8);

hold off
%L = legend([h1(1), h2(1), h3(1), h4(1), h5(1), h6(1), h7(1), h8(1), h9(1)],'SVD',...
%'PowerLU, q = 2','PowerLU, q = 3', 'PowerLU, q = 4', 'PowerLU, q = 5',...
%'PowerLU, q = 6',  'RandomLU, p = 0', 'RandomLU, p = 1',  'RandomLU, p = 2');
%L.FontSize = 20;
%[h1(1), h2(1), h3(1), h4(1), h5(1), h6(1)]
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Spectral Norm Error', 'FontSize',15,'FontWeight','bold');
%ylabel('Forbenius Error', 'FontSize',15,'FontWeight','bold');
