function [ L, U, P1, P2] = PowerLU_FP_k(A,k,b,q)
[m, n]=size(A);

L = zeros(m,k);
U = zeros(k,n);

if mod(q, 2) == 0
    Omega = randn(m,k);
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else

    Omega = rand(n,k);
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
P1 = [];

P2 = [];
%E = 0;
%E = norm(A, 'fro');
maxiter = 500;
acc= (norm(A, 'fro')^2);%/(10*sqrt(2/pi))
for i = 1:1: k/b
    %if i >1 
    %    [L1, U1] = lu(G(:, (i-1) * b + 1 : i*b) - L(:, 1:(i-1) * b) * U(1:(i-1) * b, :)* VV(:, (i-1) * b + 1 : i*b));
    %else
    [L1, U1] = lu(A * VV(:, (i-1) * b + 1 : i*b));
    %end
    L(:, (i-1) * b + 1: i *b) = L1; 
    U((i-1) * b + 1: i *b, :) =  U1 * VV(:, (i-1) * b + 1 : i*b)';
    A_ = A -  L(:, (i-1) * b + 1: i *b) * U((i-1) * b + 1: i *b, :);
    E = norm(A_, 'fro')^2;
    
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

end