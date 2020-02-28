function [ L, U, k] = RandLU_fp(A,relerr, b, p)
E = norm(A, 'fro')^2;
acc= relerr^2*E;

[m,n]=size(A);


L = [];
U = [];
Lp = [];
k = 0;
while 1
    Omg = randn(n, b);
    [Li, ~] = lu(A * Omg);
    for j= 1:1:p
        [Li, ~] = lu(A' * Li);
        [Li, ~] = lu(A * Li);
    end
    %{
    if k > 0
        [Li, ~] = lu(Li - L * Lp * Li);
    end
    Lip = Fastpinv(Li, 'gauss');
    Ui = Lip * A;
    L = [L, Li];
    U = [U;Ui];
    Lp = [Lp; Lip];
    %}
    Ui = Fastpinv(Li, 'gauss') * A;
    L = [L, Li];
    U = [U;Ui];
    A = A - Li * Ui;
    k = k + b;
    if norm(A, 'fro')^2 < acc
        break;
    end
end
end
