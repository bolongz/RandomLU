%A = gen_rand_mat_s_decay(500,400);
%A = gen_rand_mat_slow_decay(500,400);
%A = gen_rand_mat_exp_decay(500,400,7);%
clear;
[A,~] = genTestMatrix(2000, 2000, 2); %slow decay 
%[A,~] = genTestMatrix(500, 500, 3); %decay rapidly
%[A,~] = genTestMatrix(2000, 2000, 3); %S-shape
kk = 200;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2);

%powerr = zeros(dim,1);

rlu_err = zeros(dim,1);
rlu_err1 = zeros(dim,1);
rlu_err2 = zeros(dim,1);

rsvd_err = zeros(dim,1);
rsvd_err1 = zeros(dim,1);
rsvd_err2 = zeros(dim,1);

rlu_b_err = zeros(dim,1);
rlu_b_err1 = zeros(dim,1);
rlu_b_err2 = zeros(dim,1);

svderr = zeros(dim,1);
for i = 1:20
    

   
    RandLU_errs = RandLU_errors( A,ss,kk,step, 0, mode);
    rlu_err = rlu_err + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 1, mode);
    rlu_err1 = rlu_err1 + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 2, mode);
    rlu_err2 = rlu_err2 + RandLU_errs;
        %A = sprand(X(i), X(i), 0.003);

    
     RandLU_b_errs = RandLU_b_errors( A,ss,kk,step, 0, mode);
     rlu_b_err = rlu_b_err + RandLU_b_errs;
    
     RandLU_b_errs = RandLU_b_errors( A,ss,kk,step, 1, mode);
     rlu_b_err1 = rlu_b_err1 + RandLU_b_errs;
    
    
     RandLU_b_errs = RandLU_b_errors( A,ss,kk,step, 2, mode);
     rlu_b_err2 = rlu_b_err2 + RandLU_b_errs;
    
    
  
    randsvd_errs = randSVD_errors( A,ss,kk,step, 0, mode);
    rsvd_err = rsvd_err + randsvd_errs;
    
    randsvd_errs = randSVD_errors( A,ss,kk,step, 1, mode);
    rsvd_err1 = rsvd_err1 + randsvd_errs;
    
    randsvd_errs  = randSVD_errors( A,ss,kk,step, 2, mode);
    rsvd_err2 = rsvd_err2 + randsvd_errs;  Acc_randlub1.m

  
    
    
end
svd_errs = SVD_errors(A, ss, kk, step,mode);

rlu_err = [20; rlu_err];
rlu_err1 = [20; rlu_err1];
rlu_err2 = [20; rlu_err2];

rlu_b_err = [20; rlu_b_err];
rlu_b_err1 = [20; rlu_b_err1];
rlu_b_err2 = [20; rlu_b_err2];

rsvd_err = [20; rsvd_err];
rsvd_err1 = [20; rsvd_err1];
rsvd_err2 = [20; rsvd_err2];

svd_errs = [1; svd_errs];
X = [0, X];

save('acc22020randlub.mat');

