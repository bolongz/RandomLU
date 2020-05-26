clear;
A = randn(3000, 3000);


X = [100:100:500];

dim = size(X,2);

powerlu_times = zeros(dim,1);
randlu_times = zeros(dim,1);
powerlu_times2 = zeros(dim,1);
randlu_times2 = zeros(dim,1);
randsvd_times = zeros(dim,1);
randsvd_times2 = zeros(dim,1);

dimm = 0;
for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    dimm = dimm + 100;
    %A = randn(X(i), X(i));
    for ii = 1:1:20
     
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm, dimm,0. 'econ', 1);
        t2 = toc;
        randlu_times(i) = randlu_times(i) + t2;
        
        %{
        tic;
        [~, ~] = randQB_b_k(A, dimm,20, 0);
        t66 = toc;
        randQB_b_times(i) = randQB_b_times(i) + t66;
        
        tic;
        [~, ~] = randQB_b_k(A, dimm, 20, 1);
        t77 = toc;
        randQB_b_times2(i) = randQB_b_times2(i) + t77;
        
        tic;
        [~, ~] = randQB_FP_k(A, dimm,20, 0);
        t88 = toc;
        randQB_FP_times(i) = randQB_FP_times(i) + t88;
        
        tic;
        [~, ~] = randQB_FP_k(A, dimm, 20, 1);
        t99 = toc;
        randQB_FP_times2(i) = randQB_FP_times2(i) + t99;
        
        tic;
        [~, ~, ~, ~] = PowerLU_eb_k(A, dimm, dimm,20, 2);
        t100= toc;
        powerlu_eb_times(i) = powerlu_eb_times(i) + t100;
       
        tic;
        [~, ~, ~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 3);
        t1013 = toc;
        powerlu_eb_times15(i) = powerlu_eb_times15(i) + t1013;
       
        
        tic;
        [~, ~, ~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 4);
        t101 = toc;
        powerlu_eb_times2(i) = powerlu_eb_times2(i) + t101;
        
        %tic;
        %[~, ~] = PowerLU_b_k(A,dimm, dimm,20, 2);
        %t102 = toc;
        %powerlu_b_times(i) = powerlu_b_times(i) + t102;
        %tic;
        %[~, ~] = PowerLU_b_k(A, dimm, dimm, 20, 4);
        %t103 = toc;
        %powerlu_b_times2(i) = powerlu_b_times2(i) + t103;
        %}
    end
end
save('testarray.mat')