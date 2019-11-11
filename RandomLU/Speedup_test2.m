%A = gen_rand_mat_s_decay(1000,800, 7);
clear;
A = randn(8000, 8000);
%A = gen_rand_mat_s_decay(1000,800, 7);
%PowerLU, PowerLU_b, PowerLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b

X = [100:100:500];

dim = size(X,2);

powerlu_times = zeros(dim,1);
randlu_times = zeros(dim,1);
powerlu_times2 = zeros(dim,1);
randlu_times2 = zeros(dim,1);
randsvd_times = zeros(dim,1);
randsvd_times2 = zeros(dim,1);

powerlu_b_times = zeros(dim,1);
powerlu_b_times2 = zeros(dim,1);
powerlu_eb_times = zeros(dim,1);
powerlu_eb_times2 = zeros(dim,1);
powerlu_eb_times15 = zeros(dim,1);

randQB_b_times = zeros(dim,1);
randQB_b_times2 = zeros(dim,1);
randQB_FP_times = zeros(dim,1);
randQB_FP_times2 = zeros(dim,1);
dimm = 0;
for i = 1:1:dim
    %A = sprand(X(i), X(i), 0.003);
    dimm = dimm + 100;
    %A = randn(X(i), X(i));
    for ii = 1:1:20
        tic        
        [ ~, ~, ~, ~] = PowerLU(A,dimm, dimm,2);
        t1 = toc;
        powerlu_times(i) = powerlu_times(i) + t1;
        
        tic;
        [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,0,'regular');
        t2 = toc;
        randlu_times(i) = randlu_times(i) + t2;
        
        tic;
        [ ~, ~, ~, ~] = PowerLU(A,dimm, dimm,4);
        t3 = toc;
        powerlu_times2(i) = powerlu_times2(i) + t3;
        
        tic;
        [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,1,'regular');
        t33 = toc;
        randlu_times2(i) = randlu_times2(i) + t33;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm,0);
        t44 = toc;
        randsvd_times(i) = randsvd_times(i) + t44;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm, 1);
        t55 =toc;
        randsvd_times2(i) = randsvd_times2(i) + t55;
        
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
        [~, ~] = PowerLU_eb_k(A, dimm, dimm,20, 2);
        t100= toc;
        powerlu_eb_times(i) = powerlu_eb_times(i) + t100;
       
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 3);
        t1013 = toc;
        powerlu_eb_times15(i) = powerlu_eb_times15(i) + t1013;
       
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 4);
        t101 = toc;
        powerlu_eb_times2(i) = powerlu_eb_times2(i) + t101;
        
        tic;
        [~, ~] = PowerLU_b_k(A,dimm, dimm,20, 2);
        t102 = toc;
        powerlu_b_times(i) = powerlu_b_times(i) + t102;
        tic;
        [~, ~] = PowerLU_b_k(A, dimm, dimm, 20, 4);
        t103 = toc;
        powerlu_b_times2(i) = powerlu_b_times2(i) + t103;
    end
end
%{
figure(3);
subplot(1,2,1);
plot(X, powerlu_times/20, '-gx' , X, randlu_times/20, '-c*' ,X, randsvd_times/20, '-bs',...
X, randQB_b_times/20, '-c^' , X, randQB_FP_times/20, '-b<', ...
X, powerlu_b_times/20, '-kd' , X, powerlu_eb_times/20, '-ro',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_b', 'PowerLU\_eb');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
plot(X, powerlu_times2/20, '-gx' , X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
X, randQB_b_times2/20, '-c^' , X, randQB_FP_times2/20, '-b<', ...
X, powerlu_b_times2/20, '-kd' , X, powerlu_eb_times2/20, '-ro',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_b', 'PowerLU\_eb');
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
%}
save('sp3.mat')