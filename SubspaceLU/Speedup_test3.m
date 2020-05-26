%A = gen_rand_mat_s_decay(1000,800, 7);
A = randn(8000, 8000);


%A = gen_rand_mat_s_decay(1000,800, 7);
%PowerLU, PowerLU_b, PowerLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b

X = [500:100:1000];

dim = size(X,2);

D = 10;

powerlu_eb_timess = zeros(dim,1);
powerlu_eb_timess2 = zeros(dim,1);
powerlu_eb_timess3 = zeros(dim,1);

randQB_FP_timess = zeros(dim,1);
randQB_FP_timess2 = zeros(dim,1);
dimm = 0;
for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    dimm = dimm + 100;
    %A = randn(X(i), X(i));
    for ii = 1:1:D,
        tic;
        [~, ~] = randQB_FP_k(A, dimm,20, 0);
        r88 = toc;
        randQB_FP_timess(i) = randQB_FP_timess(i) +r88;
        
        tic;
        [~, ~] = randQB_FP_k(A, dimm, 20, 1);
        r99 = toc;
        randQB_FP_timess2(i) = randQB_FP_timess2(i) + r99;
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm,20, 2);
        r100 = toc;
        powerlu_eb_timess(i) = powerlu_eb_timess(i) + r100;
        
        %tic;
        %[~, ~] = PowerLU_eb_k(A, dimm, dimm,20, 3);
        %r103 = toc;
        %powerlu_eb_timess3(i) = powerlu_eb_timess3(i) + r103;
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 4);
        r101 = toc; 
        powerlu_eb_timess2(i) = powerlu_eb_timess2(i) + r101;
    end
end


subplot(1,2,1);
plot( X, randQB_FP_timess/D, '-b<', ...
 X, powerlu_eb_timess/D, '-ro',...
 X, powerlu_eb_timess3/D, '-gd',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend('RandQB\_FP', 'PowerLU\_eb', 'PowerLU\_eb:odd');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
plot(X, randQB_FP_timess2/D, '-b<', ...
X, powerlu_eb_timess2/D, '-ro',...
X, powerlu_eb_timess3/D, '-gd',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend('RandQB\_FP', 'PowerLU\_eb', 'PowerLU\_eb:odd');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');



%{

X=[100:100:1000];
dim = size(X,2);
power_times = zeros(dim,1);
rand_times = zeros(dim,1);
power_times2 = zeros(dim,1);
rand_times2 = zeros(dim,1);
randqb_times = zeros(dim,1);
randqb_times2 = zeros(dim,1);
dimm = 0;
num = 20;
for i = 1:1:dim
    dimm = dimm + 100;
    for ii = 1:1:num
        tic        
        [ ~, ~, ~, ~] = PowerRandLU(A,dimm + 5, dimm,4);
        t1 = toc;
        power_times(i) = power_times(i) + t1;
        t11 = toc;
        [~, ~, ~, ~] = randomizedLU(A,dimm + 5, dimm,1,'regular');
        t2 = toc;
        rand_times(i) = rand_times(i) + t2- t11;
        t22 = toc;
        [ ~, ~, ~, ~] = PowerRandLU(A,dimm + 5, dimm,6);
        t3 = toc;
        power_times2(i) = power_times2(i) + t3-t22;
        t33 = toc;
        [~, ~, ~, ~] = randomizedLU(A,dimm + 5, dimm,2,'regular');
        rand_times2(i) = rand_times2(i) + toc - t33;
        t44 = toc;
        [~, ~, ~] = basicQB_svd(A, dimm + 5,dimm,  1);
        randqb_times(i) = randqb_times(i) + toc - t44;
        t55 = toc;
        [~, ~, ~] = basicQB_svd(A, dimm + 5,dimm, 2);
        randqb_times2(i) = randqb_times2(i) + toc - t55;

    end
end

subplot(1,2,1);
semilogy(X, power_times/num, '--rx' , X, rand_times/num, '-c<' ,X, randqb_times/num, '-g>', 'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'PowerLU, q = 4', 'RandomLU, p = 1', 'RandomQB\_svd, p = 1');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
semilogy(X, power_times2/num, '--rx' , X, rand_times2/num, '-c<',X, randqb_times2/num, '-g>' ,'LineWidth', 1.5, 'MarkerSize', 8);
L1 = legend( 'PowerLU, q = 6', 'RandomLU, p=2', 'RandomQB\_svd, p =2');
L1.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');
%}
