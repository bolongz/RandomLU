clear;
[A,~] = genTestMatrix(2000, 2000, 1); %slow decay 
kk = 200;
ss = 10;
step = 10;
X = [ss:step:kk];
mode = 'fro';
dim = size(X,2);

rlu_err = zeros(dim,1);
rlu_err1 = zeros(dim,1);
rlu_err2 = zeros(dim,1);

for i = 1:20
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 0, mode, 1);
    rlu_err = rlu_err + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 1, mode, 1);
    rlu_err1 = rlu_err1 + RandLU_errs;
    
    RandLU_errs = RandLU_errors( A,ss,kk,step, 2, mode, 1);
    rlu_err2 = rlu_err2 + RandLU_errs;
    
    
  
end
rlu_err = [20; rlu_err];
rlu_err1 = [20; rlu_err1];
rlu_err2 = [20; rlu_err2];

save('testaccarray.mat');