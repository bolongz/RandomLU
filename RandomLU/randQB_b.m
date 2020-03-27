function [Q, B, k] = randQB_b(A,relerr, bs, p)
% [Q, B, errs] = randQB_b_k(A, k, bs, p)
% The randQB_b algorithm with fixed rank k.
% p is the power parameter, bs is rank-increase step (usually a factor of k).
% errs is the error ||A-QB||_F.
    [m, n] = size(A);
    Q = [];
    B = [];
    E = norm(A, 'fro')^2;
    acc= relerr^2*E;
    [m,n]=size(A);
    k = 0;
    while 1
   
        omg = randn(n, bs);
        y = A * omg;
        [q, ~] = qr(y, 0);
        for j=1:p,      % added by yuwj
            [q, ~]= qr(A'*q, 0);
            [q, ~]= qr(A*q, 0);
        end
        if k > 0
            [q, ~] = qr(q - Q * (Q' * q), 0);
        end
        b = q' * A;    
        Q = [Q, q];
        B = [B; b];
        A = A - q * b;
        k = k + bs;
        E = norm(A, 'fro')^2;
        if E < acc
            break;
        end
    end
end