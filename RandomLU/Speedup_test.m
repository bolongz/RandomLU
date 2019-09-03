%A = gen_rand_mat_s_decay(1000,800, 7);

X = [2000:2000:20000];
dim = size(X,2);
power_times = zeros(1,dim);
rand_times = zeros(1,dim);
i = 1;
for ii = 1:1:20
    for i = 1:1:dim
        %A = gen_rand_mat_exp_decay(X(i),X(i),5);%
        %A = gen_rand_mat_slow_decay(1000,800, 5);
        A = randn(X(i), X(i));
        tic        
        [ ~, ~, ~, ~] = PowerRandLU(A,200 + 5, 200,4);
        t1 = toc;
        power_times(i) = power_times(i) + t1;
        [~, ~, ~, ~] = randomizedLU(A,200 + 5, 200,1,'regular');
        rand_times(i) = rand_times(i) + toc - t1;
    end
end
semilogy(X, power_times/20, '--rx' , X, rand_times/20, '-c<' ,'LineWidth', 2, 'MarkerSize', 6);
legend( 'PowerLU', 'RandomLU');
