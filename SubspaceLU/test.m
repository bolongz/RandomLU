A = randn(5000 ,5000);
tic
[U, S, V] = svd(A);
toc;

tic
[Q, R, P] = qr(A);
[Q1, R1, P] = qr(R');
toc