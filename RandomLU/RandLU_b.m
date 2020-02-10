function [ L, U] = RandLU_b(A,k, b, p)

[m,n]=size(A);
L = [];
U = [];
i = 0;
while i <= k
    Omg = randn(n, b);
    [Li, ~] = lu(A * Omg);
    for j= 1:1:p
        [Li, ~] = lu(A' * Li);
        [Li, ~] = lu(A * Li);
    end
    Ui = Fastpinv(Li, 'gauss') * A;
    L = [L, Li];
    U = [U;Ui];
    A = A - Li * Ui;
    i = i + b;
    E = norm(A, 'fro')^2;
end
k = i;
end
