%A = gen_rand_mat_s_decay(1000,800, 7);
%SubspaceLU, SubspaceLU_b, SubspaceLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b
clear;

X = [2000, 4000, 8000, 16000, 24000];
dim = size(X,2);

subspacelu_times = zeros(dim,1);
subspacelu_times2 = zeros(dim,1);
randlu_times = zeros(dim,1);
randlu_times2 = zeros(dim,1);
randsvd_times = zeros(dim,1);
randsvd_times2 = zeros(dim,1);

for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    A = randn(X(i), X(i));
    for ii = 1:1:20
        dimm = 200;
        tic        
        [ ~, ~, ~, ~] = SubspaceLU(A,dimm + 5, dimm,2);
        t1 = toc;
        subspacelu_times(i) = subspacelu_times(i) + t1;
        
        tic;
        [ ~, ~, ~, ~] = SubspaceLU(A,dimm + 5, dimm,4);
        t22 = toc;
        subspacelu_times2(i) = subspacelu_times2(i) + t22;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm + 5, dimm,0);
        t44 = toc;
        randsvd_times(i) = randsvd_times(i) + t44;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm + 5, dimm, 1);
        t55 = toc;
        randsvd_times2(i) = randsvd_times2(i) + t55;
        
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm + 5, dimm,0);
        t2 = toc;
        randlu_times(i) = randlu_times(i) + t2;
      
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm + 5, dimm,1);
        t33 = toc;
        randlu_times2(i) = randlu_times2(i) + t33;
       
    end
end

save('sp11.mat');
