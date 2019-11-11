%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
[A,~] = genTestMatrix(2000, 2000, 3); %slow decay 
%[A,~] = genTestMatrix(500, 500, 3); %decay rapidly
%[A,~] = genTestMatrix(2000, 2000, 3); %S-shape
kk = 100;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2);

%powerr = zeros(dim,1);
powerlu_err2 = zeros(dim,1);
powerlu_err4 = zeros(dim,1);
powerlu_err6 = zeros(dim,1);


rlu_err = zeros(dim,1);
rlu_err1 = zeros(dim,1);
rlu_err2 = zeros(dim,1);

rlu_no_err = zeros(dim,1);
rlu_no_err1 = zeros(dim,1);
rlu_no_err2 = zeros(dim,1);

rsvd_err = zeros(dim,1);
rsvd_err1 = zeros(dim,1);
rsvd_err2 = zeros(dim,1);

powerlu_b_err2 = zeros(dim,1);
powerlu_b_err4 = zeros(dim,1);
powerlu_b_err6 = zeros(dim,1);

powerlu_eb_err2 = zeros(dim,1);
powerlu_eb_err3 = zeros(dim,1);
powerlu_eb_err4 = zeros(dim,1);
powerlu_eb_err5 = zeros(dim,1);
powerlu_eb_err6 = zeros(dim,1);

svderr = zeros(dim,1);
for i = 1:20
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,2, mode);
    powerlu_err2 = powerlu_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,4, mode);
    powerlu_err4 = powerlu_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_errors(A,ss,kk,step,6, mode);
    powerlu_err6 = powerlu_err6 + powerlu_errs;

   
    RandLU_errs = RandLU_errors( A,ss,kk,step, 0, mode);
    rlu_err = rlu_err + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 1, mode);
    rlu_err1 = rlu_err1 + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 2, mode);
    rlu_err2 = rlu_err2 + RandLU_errs;
    
    
    
    RandLU_errs = RandLU_no_errors( A,ss,kk,step, 0, mode);
    rlu_no_err = rlu_no_err + RandLU_errs;
    
    RandLU_errs = RandLU_no_errors( A,ss,kk,step, 1, mode);
    rlu_no_err1 = rlu_no_err1 + RandLU_errs;
    
    RandLU_errs = RandLU_no_errors( A,ss,kk,step, 2, mode);
    rlu_no_err2 = rlu_no_err2 + RandLU_errs;
    
    
    randsvd_errs = randSVD_errors( A,ss,kk,step, 0, mode);
    rsvd_err = rsvd_err + randsvd_errs;
    
    randsvd_errs = randSVD_errors( A,ss,kk,step, 1, mode);
    rsvd_err1 = rsvd_err1 + randsvd_errs;
    
    randsvd_errs  = randSVD_errors( A,ss,kk,step, 2, mode);
    rsvd_err2 = rsvd_err2 + randsvd_errs;  
    
     powerlu_errs = PowerLU_b_errors(A,ss,kk,step,2, mode);
    powerlu_b_err2 = powerlu_b_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_b_errors(A,ss,kk,step,4, mode);
    powerlu_b_err4 = powerlu_b_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_b_errors(A,ss,kk,step,6, mode);
    powerlu_b_err6 = powerlu_b_err6 + powerlu_errs;

    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,2, mode);
    powerlu_eb_err2 = powerlu_eb_err2 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,3, mode);
    powerlu_eb_err3 = powerlu_eb_err3 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,4, mode);
    powerlu_eb_err4 = powerlu_eb_err4 + powerlu_errs;
    
    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,5, mode);
    powerlu_eb_err5 = powerlu_eb_err5 + powerlu_errs;    

    powerlu_errs = PowerLU_eb_errors(A,ss,kk,step,6, mode);
    powerlu_eb_err6 = powerlu_eb_err6 + powerlu_errs;
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

powerlu_err2 = [20; powerlu_err2];
powerlu_err4 = [20; powerlu_err4];
powerlu_err6 = [20; powerlu_err6];

powerlu_b_err2 = [20; powerlu_b_err2];
powerlu_b_err4 = [20; powerlu_b_err4];
powerlu_b_err6 = [20; powerlu_b_err6];

powerlu_eb_err2 = [20; powerlu_eb_err2];
powerlu_eb_err3 = [20; powerlu_eb_err3];
powerlu_eb_err4 = [20; powerlu_eb_err4];
powerlu_eb_err5 = [20; powerlu_eb_err5];

powerlu_eb_err6 = [20; powerlu_eb_err6];

rlu_err = [20; rlu_err];
rlu_err1 = [20; rlu_err1];
rlu_err2 = [20; rlu_err2];

rlu_no_err = [20; rlu_no_err];
rlu_no_err1 = [20; rlu_no_err1];
rlu_no_err2 = [20; rlu_no_err2];

rsvd_err = [20; rsvd_err];
rsvd_err1 = [20; rsvd_err1];
rsvd_err2 = [20; rsvd_err2];

svd_errs = [1; svd_errs];
X = [0, X];

%profile report
%subplot(1,2,1)
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

%{


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
%}