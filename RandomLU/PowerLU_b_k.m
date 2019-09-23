function [ L, U] = PowerLU_b_k(A,l, k,b,q)
[m, n]=size(A);

L = zeros(m,k);
U = zeros(k,n);

%L = [];
%U = [];
%L_inv = [];
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
%G = A * VV;
%P1 = [];

%P2 = [];
%E = 0;
%E = norm(A, 'fro');
%maxiter = 500;
%ßacc= (norm(A, 'fro')^2);%/(10*sqrt(2/pi))
%{
for i = 1:1: k/b
  
    [L1, ~] = lu(A * VV(:, (i-1) * b + 1 : i*b));
 
    if i > 1
    
        [L1, ~] = lu(L1 - L * (L_inv * L1));
    end
    L1_inv = Fastpinv(L1, 'regular');
    L_inv = [L_inv; L1_inv];
    
    B = L1_inv * A;
    L= [L, L1];
    U= [U; B];
    A = A - L1 * B;
    E = norm(A, 'fro')^2;
   
    %{
    if E < acc
        for ii = 1:b
            A = A -  L(:, (i-1) * b + ii) * U((i-1) * b + ii, :);
            E = norm(A, 'fro')^2;
            if E < acc
                flag = true;
                break;
            end
        end
    else
        A = A_;
    end
    if flag,
        k= (i-1)*b+ii;
        break;
    end
    i = i + 1;
    %}
end
%}


for i = 1:1: k/b
    [L1, U1] = lu(A * VV(:, (i-1) * b + 1 : i*b));
    L(:, (i-1) * b + 1: i *b) = L1; 
    U((i-1) * b + 1: i *b, :) =  U1 * VV(:, (i-1) * b + 1 : i*b)';
    A = A -  L(:, (i-1) * b + 1: i *b) * U((i-1) * b + 1: i *b, :);
    E = norm(A, 'fro')^2;
end
end