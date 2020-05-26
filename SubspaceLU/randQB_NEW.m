function [U, S, V] = randQB_NEW(A, k)
% [Q, B, errs] = rankQB_FP_k(A, k, bsize, p)
% The randQB_FP algorithm with fixed rank k.
% p is the power parameter, bsize is block size (usually a factor of k).
% errs is the error ||A-QB||_F.
    [m, n]  = size(A);
 
    Omega = randn(n, k);
    %[Omg,S, ~] =svd(Omega,0);
    Omg = Omega;%// * S;
    %Omg = qr(randn(n, k), 0);
    G = A * Omg;
    H = A' * G;

    [U, S, V] = svd(H);
    V = Omg * V;
    S= sqrt(diag(S));
    
end