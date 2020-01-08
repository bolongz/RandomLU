function [ L, U] = PowerLU_eb_k_GPU(A,l, k,b,q, gpu)

[m, n]=size(A);
if nargin ==6
    gpu = true;
    L = gpuArray(zeros(m,k));
    U = gpuArray(zeros(k,n));
else
    gpu = false;
    L = zeros(m,k);
    U = zeros(k,n);
end


if mod(q, 2) == 0
    
    if gpu
        Omega = gpuArray.randn(m,l);
    else
        Omega = randn(m,l);
    end
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else
    if gpu
        VV = gpuArray.randn(n,l);
    else
        VV = randn(n,l);
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

G = A * VV;

E = norm(A, 'fro')^2;


for i = 1:1: k/b
    t1 = (i-1) * b;
    t2 = t1 + b;
    GG = G(:, t1 + 1 : t2) - L(:, 1:t1) * (U(1:t1, :)* VV(:, t1 + 1 : t2));
    [L1, U1] = lu(GG);
    L(:, t1 + 1: t2) = L1; 
    U(t1 + 1: t2, :) =  U1 * VV(:, t1 + 1 : t2)';
    E = E - norm(GG, 'fro')^2;  
end
end