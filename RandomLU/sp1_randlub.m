%A = gen_rand_mat_s_decay(1000,800, 7);
%PowerLU, PowerLU_b, PowerLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b
clear;
%X = [500:100:2000];
X = [2000, 4000, 8000, 16000, 24000, 32000];
dim = size(X,2);

LIMIT = 30000;
randlu_b_times = zeros(dim,1);
randlu_b_times2 = zeros(dim,1);
randQB_b_times = zeros(dim, 1);
randQB_b_times2 = zeros(dim, 1);
for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    A = randn(X(i), X(i));
    for ii = 1:1:20
        dimm = 200;
        
        if X(i) < LIMIT;
            tic;
            [~, ~, ~, ~] = RandLU_b(A,dimm, 20,0);
            t1111 = toc;
            randlu_b_times(i) = randlu_b_times(i) + t1111;
            tic;
            [~, ~, ~, ~] = RandLU_b(A,dimm, 20,1);
            t3333 = toc;
            randlu_b_times2(i) = randlu_b_times2(i) + t3333;
            tic;
            [~, ~] = randQB_b_k(A, dimm,20, 0);
            t66 = toc;
            randQB_b_times(i) = randQB_b_times(i) + t66;
            tic;
            [~, ~] = randQB_b_k(A, dimm, 20, 1);
            t77 = toc;
            randQB_b_times2(i) = randQB_b_times2(i) +t77;
       end
        
    end
end
save('sp12020luqb.mat');
