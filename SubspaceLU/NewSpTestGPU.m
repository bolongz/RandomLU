%A = gen_rand_mat_s_decay(1000,800, 7);
%SubspaceLU, SubspaceLU_b, SubspaceLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b
clear;

A = randn(8000, 8000);
X = [100:100:1000];
dim = size(X,2);

subspacelu_times = zeros(dim,1);
subspacelu_times2 = zeros(dim,1);
randlu_times = zeros(dim,1);
randlu_times2 = zeros(dim,1);
randsvd_times = zeros(dim,1);
randsvd_times2 = zeros(dim,1);

dimm = 0;
for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    %A = randn(X(i), X(i));
    dimm = dimm + 100;
    for ii = 1:1:20
        tic        
        [ ~, ~, ~, ~] = SubspaceLU(A,dimm, dimm,2, true);
        t1 = toc;
        subspacelu_times(i) = subspacelu_times(i) + t1;
        
        tic;
        [ ~, ~, ~, ~] = SubspaceLU(A,dimm, dimm,4, true);
        t22 = toc;
        subspacelu_times2(i) = subspacelu_times2(i) + t22;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm,0 , true);
        t44 = toc;
        randsvd_times(i) = randsvd_times(i) + t44;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm, 1, true);
        t55 = toc;
        randsvd_times2(i) = randsvd_times2(i) + t55;
        
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm, dimm,0, 'econ',true);
        t2 = toc;
        randlu_times(i) = randlu_times(i) + t2;
      
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm, dimm,1, 'econ', true);
        t33 = toc;
        randlu_times2(i) = randlu_times2(i) + t33;
       
    end
end

save('NewSPGPU.mat');
