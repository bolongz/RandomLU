function [A, d] =GenerateMatrix(m, n, s)

    L = randn(m, s);
    [U, ~] = qr(L, 0);
    L = randn(n, s);
    [V, ~] = qr(L, 0);
    l = 1/s;
    d= [1:-l:l];
    E = randn(m, n);
    S= spdiags(d', 0, s, s);
    [~, length] = size(d);
    sigma = d(1, int32(3 * length/4))
    A = U * S * V' + 0.1 * sigma * randn(m, n);
