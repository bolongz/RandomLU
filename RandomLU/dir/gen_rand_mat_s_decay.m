function [A, d] = gen_rand_mat_s_decay(m, n)
% [A, d] = gen_rand_mat_exp_decay(m, n, t)
% Generate an mxn matrix A, whose the j-th singular value is exp(-j/t).
% d is the vector of singular values.
    L = randn(m, m);
    [U, ~] = qr(L);
    L = randn(n, n);
    [V, ~] = qr(L);
    t = min(m,n);
    d = zeros(1, min(m,n));
    d = 0.0001+1./(1+exp((1:t)-30));
    S= spdiags(d', 0, m, n);
    A = U * S * V;
