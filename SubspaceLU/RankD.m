function [VV, k, flag] = RankD(A,acc,b, q)

[m, n]=size(A);
maxiter = 50;

maxiter= min(maxiter, ceil(min(m,n)/3/b));
maxcol= b*maxiter;      

L =zeros(m,maxcol);
U = zeros(maxcol,n);

flag = false;
E = norm(A, 'fro')^2;
%acc= relerr^2*E;

if mod(q, 2) == 0
    Omega = randn(m,maxcol);
    if q > 2
        [VV, ~] =  lu(A' * Omega);
    else
        [VV, ~] = qr(A' * Omega, 0);
    end
else

    VV = randn(n,maxcol);
    
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
    t1 = (i-1) * b;
    t2 = t1 + b;  
    temp = E- norm(G(:, t1 + 1 : t2), 'fro')^2;
    if temp< acc,     % for precise rank determination 
        for j=1:b,
            E= E-norm(G(:,t1+j), 'fro')^2;
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
if ~flag
    k = maxcol;
end
