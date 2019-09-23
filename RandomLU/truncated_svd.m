function k = truncated_svd(A, relerr)

[m,n] = size(A);
tic;
[U, S, V] = svd(A);
toc

E = norm(A, 'fro')^2;

err = (relerr)^2 * E;

sum = 0;
for i = min(m,n):-1:1
    sum = sum + S(i,i)^2;
    if sum > err
         k = i;
         break;
    end

end
    
end
