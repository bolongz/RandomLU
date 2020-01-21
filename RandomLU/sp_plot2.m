
subplot(1,2,1);
plot(X, powerlu_times/20, '-gx' , X, randlu_times/20, '-c*' ,X, randsvd_times/20, '-bs',...
X, randQB_b_times/20, '-c^' , X, randQB_FP_times/20, '-b<', ...
X, powerlu_eb_times/20, '-ro',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_FP');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);
plot(X, powerlu_times2/20, '-gx' , X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
X, randQB_b_times2/20, '-c^' , X, randQB_FP_times2/20, '-b<', ...
X, powerlu_eb_times2/20, '-ro',...
'LineWidth', 1.5, 'MarkerSize', 8);
L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_FP');
L.FontSize = 20;
xlabel('n', 'FontSize',15,'FontWeight','bold');
ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');


%{
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
