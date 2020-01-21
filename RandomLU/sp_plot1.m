subplot(1,2,1);

if X(length(X)) > LIMIT
    semilogy(X, powerlu_times/20, '-gx', 'LineWidth', 1.5, 'MarkerSize', 8);
        hold on
    semilogy(X(1:(length(X)-1)), randlu_times(1:(length(X)-1))/20, '-c*', 'LineWidth', 1.5, 'MarkerSize', 8);   
        
    semilogy(X, randsvd_times/20, '-bs','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X(1:(length(X)-1)), randQB_b_times(1:(length(X)-1))/20, '-c^','LineWidth', 1.5, 'MarkerSize', 8);
    
    semilogy(X, randQB_FP_times/20, '-b<', 'LineWidth', 1.5, 'MarkerSize', 8);
    
    %semilogy(X(1:(length(X)-1)), powerlu_b_times(1:(length(X)-1))/20, '-kd' ,'LineWidth', 1.5, 'MarkerSize', 8);

    semilogy(X, powerlu_eb_times/20, '-ro','LineWidth', 1.5, 'MarkerSize', 8);
   
else
    semilogy(X, powerlu_times/20, '-gx' , X, randlu_times/20, '-c*' ,X, randsvd_times/20, '-bs',...
    X, randQB_b_times/20, '-c^' , X, randQB_FP_times/20, '-b<', ...
    X, powerlu_eb_times/20, '-ro',...
    'LineWidth', 1.5, 'MarkerSize', 8);
  
end
hold off
  L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP',  'PowerLU\_FP');
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
    
    %semilogy(X(1:(length(X)-1)), powerlu_b_times2(1:(length(X)-1))/20, '-kd' ,'LineWidth', 1.5, 'MarkerSize', 8);

    semilogy(X, powerlu_eb_times2/20, '-ro','LineWidth', 1.5, 'MarkerSize', 8);
    
    
else
   semilogy(X, powerlu_times2/20, '-gx' , X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
    X, randQB_b_times2/20, '-c^' , X, randQB_FP_times2/20, '-b<', ...
    X, powerlu_eb_times2/20, '-ro',...
    'LineWidth', 1.5, 'MarkerSize', 8);

end
 L = legend( 'PowerLU', 'RandLU', 'RandSVD', 'RandQB\_b', 'RandQB\_FP', 'PowerLU\_FP');
    L.FontSize = 20;
    xlabel('n', 'FontSize',20,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',20,'FontWeight','bold');
%{
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
%}