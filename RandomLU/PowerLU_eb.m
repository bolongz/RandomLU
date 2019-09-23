function [L, U, k] = PowerLU_eb(A,relerr,b, q)

[m, n]=size(A);
maxiter = 50;

maxiter= min(maxiter, ceil(min(m,n)/3/b));
maxcol= b*maxiter;      

L =zeros(m,maxcol);
U = zeros(maxcol,n);

flag = false;
E = norm(A, 'fro')^2;
acc= relerr^2*E;

if mod(q, 2) == 0
    Omega = randn(m,maxcol);
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else

    Omega = rand(n,maxcol);
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
G = A * VV;

i = 1;
k = 0;
while i * b < maxcol,
    [L1, U1] = lu(G(:, (i-1) * b + 1 : i*b) - L(:, 1:(i-1) * b) * (U(1:(i-1) * b, :)* VV(:, (i-1) * b + 1 : i*b)));
    L(:, (i-1) * b + 1: i *b) = L1; 
    U((i-1) * b + 1: i *b, :) =  U1 * VV(:, (i-1) * b + 1 : i*b)';
            
    temp = E- norm(L1 * U1, 'fro')^2;
    
    if temp< acc,     % for precise rank determination 
        for j=1:b,
            E= E-norm(L1(:,j) * U1(j,:), 'fro')^2;
            if E< acc,
                flag= true;
                break;
            end
        end
    else
        E= temp;
    end
   
    if flag,
        k= (i-1)*b+j;
        break;
    end
    i = i +1;
  
end

if E > acc
    fprintf('Warning: the accuracy is not attained with the maximum iteration: %d', maxcol);
end

end