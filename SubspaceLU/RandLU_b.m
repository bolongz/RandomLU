function [ L, U] = RandLU_b(A,k, b, p)

[m,n]=size(A);
L = [];
U = [];
%Lp = [];
for i = 1:1:k/b
    Omg = randn(n, b);
    [Li, ~] = lu(A * Omg);
    for j= 1:1:p
        [Li, ~] = lu(A' * Li);
        [Li, ~] = lu(A * Li);
    end
    %{
    if i > 2
        [Li, ~] = lu(Li - L * (Lp * Li));
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
    E = norm(A, 'fro')^2;
end
end
