%X = X(1:(length(X)-1))
subplot(1,2,1);
semilogy(X, randlu_b_times/20, '-gx' , X, randQB_b_times/20, '-m*' ,...
'LineWidth', 1.5, 'MarkerSize', 8);
  
  L = legend( 'RandLU\_b', 'RandQB\_b');
  L.FontSize = 20;
  set(gca,'FontSize',18)
  xlabel('n', 'FontSize',20,'FontWeight','bold');
  ylabel('Computational Time', 'FontSize',20,'FontWeight','bold');

subplot(1,2,2);
   semilogy(X, randlu_b_times2/20, '-gx' , X, randQB_b_times2/20, '-m*' ,...
'LineWidth', 1.5, 'MarkerSize', 8);
  
  L = legend( 'RandLU\_b', 'RandQB\_b');
    L.FontSize = 20;
    set(gca,'FontSize',18)
    xlabel('n', 'FontSize',20,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',20,'FontWeight','bold');
