function [ L, U, P1, P2] = PowerRandLU(A,l,k,q)

[m, n]=size(A);

if mod(q, 2) == 0
    Omega = randn(m,l);
    if q > 2
        [VV, ~, P1] =  lu(A' * Omega,'vector');
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else
    Omega = rand(n,l);
    if q > 2
        [VV, ~, P1] =  lu(Omega,'vector');
    else
        [VV, ~] = qr(Omega, 0);
    end
end
v = floor((q-1)/2);
for ii = 1:v
    [VV, ~, P1] = lu(A * VV(TransposePermutation(P1),: ),  'vector');
    if ii == v
        [VV, ~] = qr(A' * VV(TransposePermutation(P1),: ), 0);  
    else
        [VV, ~, P1] = lu(A' * VV(TransposePermutation(P1),: ), 'vector');             
    end
end

[LL, U, P1] = lu( A * VV(:, 1:k), 'vector');
[U,L1,P2] = lu(VV(:, 1:k) * U','vector');
L = LL*L1';
U = U';
end