function [ L, U, P1, P2] = PowerLU_singlepass(A,k)

[m, n]=size(A);
Omega = randn(m,k);
Y = A' * Omega;
[LL, U, P1] = lu( A * Y, 'vector');
Yinv = Fastpinv(Y,'regular');

[U,L1,P2] = lu(Yinv' * U','vector');
L = LL*L1';
U = U';
end