function [L, U, P1, P2, k] = PowerLU_ebt(A,relerr,b, q)

E = norm(A, 'fro')^2;
acc= relerr^2*E;

[V, k, flag] = RankD(A,acc,b, q);

if ~flag 
    [V1, k1, flag] = RankD(A-A*V*V',acc,b, q);
end
k = k + k1;
VV = [V, V1];
G = A * VV;
[LL, U, P1] = lu(G(:, 1:k), 'vector');
[U,L1,P2] = lu(VV(:, 1:k) * U','vector');
L = LL*L1';
U = U';
end