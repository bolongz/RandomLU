%A = gen_rand_mat_s_decay(1000,800, 7);

X = [1000:200:2000];
dim = size(X,2);
power_times = zeros(1,dim);
rand_times = zeros(1,dim);
power_times2 = zeros(1,dim);
rand_times2 = zeros(1,dim);
i = 1;
for ii = 1:1:20
    for i = 1:1:dim
        %A = gen_rand_mat_exp_decay(X(i),X(i),5);%
        %A = gen_rand_mat_slow_decay(1000,800, 5);
        A = randn(X(i), X(i));
        dimm = X(i);
        tic        
        [ ~, ~, ~, ~] = PowerRandLU(A,dimm, dimm,4);
        t1 = toc;
        power_times(i) = power_times(i) + t1;
        t11 = toc;
        [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,1,'regular');
        t2 = toc;
        rand_times(i) = rand_times(i) + t2- t11;
        t22 = toc;
        [ ~, ~, ~, ~] = PowerRandLU(A,dimm, dimm,4);
        t3 = toc;
        power_times2(i) = power_times2(i) + t3-t22;
        t33 = toc;
        [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,1,'regular');
        rand_times2(i) = rand_times2(i) + toc - t33;
    end
end
subplot(1,2,1);
semilogy(X, power_times/20, '--rx' , X, rand_times/20, '-c<' ,'LineWidth', 2, 'MarkerSize', 6);
legend( 'PowerLU, q = 4', 'RandomLU, p = 1');
subplot(1,2,2);
semilogy(X, power_times2/20, '--rx' , X, rand_times2/20, '-c<' ,'LineWidth', 2, 'MarkerSize', 6);
legend( 'PowerLU, q = 6', 'RandomLU, p=2');

