function [A, d] =GenerateMatrix(m, n, s)
    
    L = randn(m, s);
    [U, ~] = qr(L, 0);
    L = randn(n, s);
    [V, ~] = qr(L, 0);
    l = 1/s;
    d= [1:1:s];
    E = randn(m, n);
    S= spdiags(d', 0, s, s);
    %[~, length] = size(d);
    %sigma = d(1, l);%, int32(3 * length/4));
    A = U * S * V'+ 0.0001* randn(m, n);
