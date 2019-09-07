function [ L, U, P1, P2] = PowerRandLU_truncated(A,l,k,q)

[m, n]=size(A);

if mod(q, 2) == 0
    Omega = randn(m,l);
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else
    Omega = rand(n,l);
    if q > 2
        [VV, ~] =  lu(Omega);
    else
        [VV, ~] = qr(Omega, 0);
    end
end
v = floor((q-1)/2);
for ii = 1:v
    [VV, ~] = lu(A * VV);
    if ii == v
        [VV, ~] = qr(A' * VV, 0);  
    else
        [VV, ~] = lu(A' * VV);             
    end
end

[LL, U, P1] = lu( A * VV, 'vector');
[U,L1,P2] = lu(VV * U','vector');
L = LL*L1';
U = U';
L = L(:, 1:k);
U = U(1:k,:);
end