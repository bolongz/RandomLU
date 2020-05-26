%A = gen_rand_mat_s_decay(1000,800, 7);
clear;
A = randn(8000, 8000);
%[A,~] = genTestMatrix(3000, 3000, 2);%A = gen_rand_mat_s_decay(1000,800, 7);
%PowerLU, PowerLU_b, PowerLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b

X = [100:100:1000];

dim = size(X,2);

randlu_times = zeros(dim,1);
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
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm, dimm,0);
        t2 = toc;
        randlu_times(i) = randlu_times(i) + t2;
        
        tic;
        [~, ~, ~, ~] = randomizedLU_gauss(A,dimm, dimm,1);
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
%}
save('splusvd8.mat')
