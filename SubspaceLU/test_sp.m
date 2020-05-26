

A = randn(200, 200);
%{
time1 = 0;
time2 = 0;
for i = 1:100
    tic; [~, s1, ~ ] = randQB_NEW(A, 200); 
    tt = toc;
    time1 = time1 + tt;
end

for i = 1:100
    tic; [~, s2, ~ ] = rSVDsp(A, 200, 10);
    tt = toc;
    time2 = time2 + tt;
    
end
%}
s = svds(A, 20);
[~, s1, ~ ] = randQB_NEW(A, 20);
[~, s2, ~ ] = rSVDsp(A, 20, 10);
X = [1:1:20];

semilogy(X, s, '-gx' , X, s1, '-c*' ,X,s2, 'LineWidth', 1.5, 'MarkerSize', 8);

 L = legend( 'SVD', 'NEW', 'SP');
    L.FontSize = 20;
    xlabel('n', 'FontSize',15,'FontWeight','bold');
    ylabel('Computational Time', 'FontSize',15,'FontWeight','bold');