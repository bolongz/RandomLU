function [ L, U] = PowerLU_b_k(A,l,k,b,q)
[m, n]=size(A);

L = zeros(m,k);
U = zeros(k,n);


if mod(q, 2) == 0
    Omega = randn(m,l);
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else
    VV = randn(n,l);    
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

for i = 1:1: k/b
    t1 = (i-1) * b;
    t2 = t1 + b;
    GG = A * VV(:, t1 + 1 : t2);
    [L1, U1] = lu(GG);
    L(:, t1 + 1: t2) = L1; 
    U(t1+ 1: t2, :) =  U1 * VV(:, t1 + 1 : t2)';
    %A = A -  L(:, t1 + 1: t2) * U(t1 + 1: t2, :);
    A = A - GG * VV(:, t1 + 1 : t2)';
    E = norm(A, 'fro')^2;
end
end