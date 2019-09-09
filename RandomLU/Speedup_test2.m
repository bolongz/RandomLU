%A = gen_rand_mat_s_decay(1000,800, 7);

X = [500:100:1000];
dim = size(X,2);

randqbb_times = zeros(dim,1);
randqbb_times2 = zeros(dim,1);

randqbfp_times = zeros(dim,1);
randqbfp_times2 = zeros(dim,1);
powerlufp_times = zeros(dim,1);
powerlufp_times2 = zeros(dim,1);
for i = 1:1:dim
    A = randn(X(i), X(i));
    for ii = 1:1:20
        dimm = 100;
        tic   
        [~, ~] = randQB_b_k(A, dimm,10, 1);
        randqbb_times(i) = randqbb_times(i) + toc;
        t22 = toc;
        [~, ~] = randQB_b_k(A, dimm, 10, 2);
        randqbb_times2(i) = randqbb_times2(i) + toc - t22;
        t33 = toc;
        [~, ~] = randQB_FP_k(A, dimm,10, 1);
        randqbfp_times(i) = randqbfp_times(i) + toc - t33;
        t44 = toc;
        [~, ~] = randQB_FP_k(A, dimm, 10, 2);
        randqbfp_times2(i) = randqbfp_times2(i) + toc - t44;
        t55 = toc;
        [~, ~, ~, ~] = PowerLU_FP_k(A, dimm,10, 4);
        powerlufp_times(i) = powerlufp_times(i) + toc - t55;
        t66 = toc;
        [~, ~, ~, ~] = PowerLU_FP_k(A, dimm, 10, 6);
        powerlufp_times2(i) = powerlufp_times2(i) + toc - t66;
    end
end

subplot(1,2,1);
semilogy(X, randqbb_times/20, '--g^' , X, randqbfp_times/20, '-c<' ,X, powerlufp_times/20, '-.b>','LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'RandomQB\_blocked, p = 1', 'RandQB\_FP, p =1', 'Range_finder, q = 4');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
semilogy(X, randqbb_times2/20, '--g^' ,X, randqbfp_times2/20, '-c<' ,X, powerlufp_times2/20, '-.b>','LineWidth', 1.5, 'MarkerSize', 8);

L1 = legend( 'RandomQB\_blocked, p = 1', 'RandQB\_FP, p =1', 'Range_finder, q = 4');
L1.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

