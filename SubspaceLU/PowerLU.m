function [L, U, P1, P2] = PowerLU(A,l,k,q, gpu)

[m, n]=size(A);

if nargin<3,
    q=0;
    gpu = false;
end

if mod(q, 2) == 0
    
    if gpu
        Omega = gpuArray.randn(m,l);
    else
        Omega = randn(m,l);
    end

    Omega = randn(m,l);
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

[LL, U, P1] = lu( A * VV(:, 1:k), 'vector');
[U,L1,P2] = lu(VV(:, 1:k) * U','vector');
L = LL*L1';
U = U';
end