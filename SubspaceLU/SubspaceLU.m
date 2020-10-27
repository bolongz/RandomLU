function [L, U, P1, P2] = SubspaceLU(A,l,k,q, gpu)

[m, n]=size(A);

if nargin <5,
    gpu = false;
end
if mod(q, 2) == 0
    
    if gpu
        A = gpuArray(A);
        Omega = gpuArray.randn(m,l);
    else
        Omega = randn(m,l);
    end
    
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        %[VV, ~, ~] = eigSVD(A' * Omega);
        
        [VV, ~] = qr(A' * Omega, 0);  
        %[VV, ~, ~] = eigSVD(A' * Omega); 
        % [VV, ~, ~] = svd(A' * VV, 0);  

    end
else
    
    if gpu
        A = gpuArray(A);
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
        %[VV, ~, ~] = eigSVD(A' * VV);  
        %[VV, ~, ~] = svd(A' * VV, 0);  

    else
        [VV, ~] = lu(A' * VV);             
    end
end
%ind = l-k+1:1:l;

[LL, U, P1] = lu( A * VV(:, 1:k), 'vector');
[U,L1,P2] = lu(VV(:, 1:k) * U','vector');


L = LL*L1';
U = U';
%if gpu
%    L = gather(L);
%    U = gather(U);
%    P1 = gather(P1);
%    P2 = gather(P2);
%end
end