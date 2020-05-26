
   semilogy(blocks,res_200/20, '-gx' , blocks, res_400/20, '-c*' ,blocks, res2_200/20, '-bs',...
    blocks, res2_400/20, '-c^' , blocks, res3_200/20, '-b<', ...
    blocks, res3_400, '-kd' ,...
    'LineWidth', 1.5, 'MarkerSize', 8);

 L = legend( 'k=200, 3000x3000', 'k=400, 3000x3000', 'k=200, 2000x6000', 'k=400, 2000x6000', 'k=200, 6000x2000', 'k=400, 6000x2000');
    L.FontSize = 20;
    xlabel('n', 'FontSize',15,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');