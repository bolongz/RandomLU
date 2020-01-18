%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
clear;
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

save('acc32020.mat');