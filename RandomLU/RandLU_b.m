function [ L, U] = RandLU_b(A,k, b, p)

[m,n]=size(A);
L = [];
U = [];
Lp = [];
i = 0;
while i <= k
    Omg = randn(n, b);
    [Li, ~] = lu(A * Omg);
    for j= 1:1:p
        [Li, ~] = lu(A' * Li);
        [Li, ~] = lu(A * Li);
    end
    if i > 0
        [Li, ~] = lu(Li - L * (Lp * Li));
    end
    Lip = Fastpinv(Li, 'gauss');
    Ui = Lip * A;
    L = [L, Li];
    U = [U;Ui];
    Lp = [Lp; Lip];
    
    %{
    Ui = Fastpinv(Li, 'gauss') * A;
    L = [L, Li];
    U = [U;Ui];
    %}
    A = A - Li * Ui;
    i = i + b;
    E = norm(A, 'fro')^2;
end
k = i;
end
