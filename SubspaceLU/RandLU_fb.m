function [ L, U, k] = RandLU_fb( A,relerr, b, p)

E = norm(A, 'fro')^2;
acc= relerr^2*E;

l = 100 * b;
[m,n]=size(A);

L = [];
U = [];
k = 0

Omg = randn(m, l);
[Omg, ~] = lu(A' * Omg);
for j= 1:1:p
    [Omg, ~] = lu(A * Omg);
    [Omg, ~] = lu(A' * Omg);
end
i = 1;
while 1
    [Li, ~] = lu(A * Omg(:, (i-1)*b+1:i*b));
    Ui = Fastpinv(Li, 'gauss') * A;
    L = [L, Li];
    U = [U;Ui];
    A = A - Li * Ui;
    k = k + b;
    i = i +1;
    aa = norm(A,'fro')^2
    bb = acc
    if norm(A, 'fro')^2 < acc
        break;
    end
end

end