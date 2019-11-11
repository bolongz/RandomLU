%A = gen_rand_mat_s_decay(1000,800, 7);
%PowerLU, PowerLU_b, PowerLU_eb, RandLU, RandSVD, RandQB_FP, RandQB_b

X = [500:100:2000];
%X = [2000, 4000, 8000, 16000, 24000, 32000];
dim = size(X,2);

LIMIT = 30000;
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

for i = 1:1:dim
    A = sprand(X(i), X(i), 0.003);
    %A = randn(X(i), X(i));
    for ii = 1:1:20
        dimm = 200;
        tic        
        [ ~, ~, ~, ~] = PowerLU(A,dimm, dimm,2);
        t1 = toc;
        powerlu_times(i) = powerlu_times(i) + t1;
        tic;
        [ ~, ~, ~, ~] = PowerLU(A,dimm, dimm,4);
        t22 = toc;
        powerlu_times2(i) = powerlu_times2(i) + t22;
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm,0);
        t44 = toc;
        randsvd_times(i) = randsvd_times(i) + t44;
        
        tic;
        [~, ~, ~] = basicQB_svd(A, dimm, dimm, 1);
        t55 = toc;
        randsvd_times2(i) = randsvd_times2(i) + t55;
        
        tic;
        [~, ~] = randQB_FP_k(A, dimm,20, 0);
        t88 = toc;
        randQB_FP_times(i) = randQB_FP_times(i) + t88;
        
        tic;
        [~, ~] = randQB_FP_k(A, dimm, 20, 1);
        t99 =toc;
        randQB_FP_times2(i) = randQB_FP_times2(i) + t99;
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm,dimm, 20, 2);
        t100 = toc;
        powerlu_eb_times(i) = powerlu_eb_times(i) + t100;
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 4);
        t1013 = toc;
        powerlu_eb_times15(i) = powerlu_eb_times15(i) + t1013;
        
        
        tic;
        [~, ~] = PowerLU_eb_k(A, dimm, dimm, 20, 4);
        t101 = toc;
        powerlu_eb_times2(i) = powerlu_eb_times2(i) + t101;
        
        
        
        if X(i) < LIMIT;
            tic;
            [~, ~] = PowerLU_b_k(A, dimm,dimm, 20, 2);
            t102 = toc;
            powerlu_b_times(i) = powerlu_b_times(i) + t102;   
            tic;
            [~, ~] = PowerLU_b_k(A, dimm, dimm, 20, 4);
            t103 = toc;
            powerlu_b_times2(i) = powerlu_b_times2(i) + t103;
            tic;
            [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,0,'regular');
            t11 = toc;
            randlu_times(i) = randlu_times(i) + t11;
            tic;
            [~, ~, ~, ~] = randomizedLU(A,dimm, dimm,1,'regular');
            t33 = toc;
            randlu_times2(i) = randlu_times2(i) + t33;
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


subplot(1,2,1);

if X(length(X)) > LIMIT
    semilogy(X, powerlu_times/20, '-gx', 'LineWidth', 1.5, 'MarkerSize', 8);
        hold on
    semilogy(X(1:(length(X)-1)), randlu_times(1:(length(X)-1))/20, '-c*', 'LineWidth', 1.5, 'MarkerSize', 8);   
        
    semilogy(X, randsvd_times/20, '-bs','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X(1:(length(X)-1)), randQB_b_times(1:(length(X)-1))/20, '-c^','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X, randQB_FP_times/20, '-b<', 'LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X(1:(length(X)-1)), powerlu_b_times(1:(length(X)-1))/20, '-kd' ,'LineWidth', 1.5, 'MarkerSize', 8);

    semilogy(X, powerlu_eb_times/20, '-ro','LineWidth', 1.5, 'MarkerSize', 8);
   
else
    semilogy(X, powerlu_times/20, '-gx' , X, randlu_times/20, '-c*' ,X, randsvd_times/20, '-bs',...
    X, randQB_b_times/20, '-c^' , X, randQB_FP_times/20, '-b<', ...
    X, powerlu_b_times/20, '-kd' , X, powerlu_eb_times/20, '-ro',...
    'LineWidth', 1.5, 'MarkerSize', 8);
  
end
hold off
  L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_b', 'PowerLU\_eb');
  L.FontSize = 20;
  xlabel('n', 'FontSize',15,'FontWeight','bold');
  ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

subplot(1,2,2);

if X(length(X)) > LIMIT
    
     semilogy(X, powerlu_times2/20, '-gx', 'LineWidth', 1.5, 'MarkerSize', 8);
        hold on
    semilogy(X(1:(length(X)-1)), randlu_times2(1:(length(X)-1))/20, '-c*', 'LineWidth', 1.5, 'MarkerSize', 8);   
        
    semilogy(X, randsvd_times2/20, '-bs','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X(1:(length(X)-1)), randQB_b_times2(1:(length(X)-1))/20, '-c^','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X, randQB_FP_times2/20, '-b<', 'LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X(1:(length(X)-1)), powerlu_b_times2(1:(length(X)-1))/20, '-kd' ,'LineWidth', 1.5, 'MarkerSize', 8);

    semilogy(X, powerlu_eb_times2/20, '-ro','LineWidth', 1.5, 'MarkerSize', 8);
    
    
else
   semilogy(X, powerlu_times2/20, '-gx' , X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
    X, randQB_b_times2/20, '-c^' , X, randQB_FP_times2/20, '-b<', ...
    X, powerlu_b_times2/20, '-kd' , X, powerlu_eb_times2/20, '-ro',...
    'LineWidth', 1.5, 'MarkerSize', 8);

end
 L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_b', 'PowerLU\_eb');
    L.FontSize = 20;
    xlabel('n', 'FontSize',15,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

