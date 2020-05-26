%subplot(1,2,1);

if X(length(X)) > LIMIT
   
    semilogy(X(1:(length(X)-1)), randlu_times(1:(length(X)-1))/20, '-c*', 'LineWidth', 1.5, 'MarkerSize', 8);   
    hold on 
    semilogy(X, randsvd_times/20, '-bs','LineWidth', 1.5, 'MarkerSize', 8);
   
else
    semilogy(X, randlu_times/20, '-c*' ,X, randsvd_times/20, '-bs',...
    'LineWidth', 1.5, 'MarkerSize', 8);
  
end
hold off
  L = legend('Randomized LU', 'RandSVD');
  L.FontSize = 20;
  xlabel('n', 'FontSize',15,'FontWeight','bold');
  ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');

%{
subplot(1,2,2);

if X(length(X)) > LIMIT
    
    
    semilogy(X(1:(length(X)-1)), randlu_times2(1:(length(X)-1))/20, '-c*', 'LineWidth', 1.5, 'MarkerSize', 8);   
    hold on
    semilogy(X, randsvd_times2/20, '-bs','LineWidth', 1.5, 'MarkerSize', 8);
    
    
else
   semilogy(X, randlu_times2/20, '-c*' ,X, randsvd_times2/20, '-bs',...
    'LineWidth', 1.5, 'MarkerSize', 8);

end
 L = legend('Randomized LU', 'RandSVD');
    L.FontSize = 20;
    xlabel('n', 'FontSize',15,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');
  
  %}