A = randn(3000, 3000);

X=[50:50:500];
dim = size(X,2);
rand_times = zeros(dim,1);
rand_times2 = zeros(dim,1);
randqb_times = zeros(dim,1);
randqb_times2 = zeros(dim,1);

num = 20;
for ii = 1:1:num
    dimm = 0;
    for i = 1:1:dim
        dimm = dimm + 50;
        tic        
        [~, ~, ~, ~] = randomizedLU(A,dimm + 3, dimm,0,'regular');
        t2 = toc;
        rand_times(i) = rand_times(i) + t2;
        t33 = toc;
        [~, ~, ~, ~] = randomizedLU(A,dimm + 3, dimm,1,'regular');
        rand_times2(i) = rand_times2(i) + toc - t33;
        t44 = toc;
        [~, ~, ~] = basicQB_svd(A, dimm + 3, dimm, 0);
        randqb_times(i) = randqb_times(i) + toc - t44;
        t55 = toc;
        [~, ~, ~] = basicQB_svd(A, dimm + 3, dimm, 1);
        randqb_times2(i) = randqb_times2(i) + toc - t55;

    end
end

subplot(1,2,1);
semilogy(X, rand_times/num, '-c<' ,X, randqb_times/num, '-g>', 'LineWidth', 1.5, 'MarkerSize', 8);
L = legend('RandomLU, p = 0', 'RandomSvd, p = 0');
L.FontSize = 20;
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
semilogy(X, rand_times2/num, '-c<',X, randqb_times2/num, '-g>' ,'LineWidth', 1.5, 'MarkerSize', 8);
L1 = legend('RandomLU, p=1', 'RandomSvd, p =1');
L1.FontSize = 20;
xlabel('k', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

