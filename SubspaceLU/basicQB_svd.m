function [U, S, V]=basicQB_svd(A, l, k, P, gpu)
% [U, S, V]=basicQB_svd(A, k, P)
% Rank-k truncated SVD of A based on the basic randQB algorithm.
% Syntax:
%  s = basicQB_svd(A, k)
%  s = basicQB_svd(A, k, P)
%  [U, S, V]= basicQB_svd(A, k)
%  [U, S, V]= basicQB_svd(A, k, P)
%  -P is an optional parameter to balance time and accuacy (default value 0).
%   With large P, the accuracy increases with runtime overhead.

if nargin<3,
    P=0;
    gpu = false;
end

              % over-sampling
[m,n]= size(A);

if gpu
    B = gpuArray.randn(n,l);
    A = gpuArray(A);
else
    B = randn(n,l);
end

%B= randn(n, l);
U= A*B;
[U, ~]= qr(U, 0);
for j=1:P,
    [B, ~]= lu(A'*U);   % May reduce an orthogonalization
    if j == P
        [U, ~]= qr(A*B, 0);
    else
        [U, ~] = lu(A * B);
    end
end
B= A'*U;

if nargout==1,
    U= svd(B','econ');
    U= U(1:k);
else
    [U1, S, V]= svd(B', 'econ');
    U= U*U1(:,1:k);
    S= S(1:k,1:k);
    V= V(:,1:k);
end

if gpu
    U = gather(U);
    S = gather(S);
    V = gather(V);
end
end 
