function [A, d] = gen_rand_mat_s_decay(m, n, r)
% [A, d] = gen_rand_mat_exp_decay(m, n, t)
% Generate an mxn matrix A, whose the j-th singular value is exp(-j/t).
% d is the vector of singular values.
    L = randn(m, m);
    [U, ~] = qr(L);
    L = randn(n, n);
    [V, ~] = qr(L);
    t = min(m,n);
    for i = 1:min(m, n)
        if i <= t/2
            d(i) = 10^(1+tanh(5*(-1+2*i/t)));
        else
            d(i) = 10^(-2);
        end
    end
    S= spdiags(d', 0, m, n);
    A = U * S * V;
