function [A, P] = LU(A, mode)

% Common LU Decomposition


if nargin > 2
    msg = 'Error occurred. Too much Input Parameters';
    error(msg)
end

if nargin ~= 2
    mode = 'vector';
end 

[m,n] = size(A);

P = (1:m);

r = min(m,n);

[L,U,P] = lu(A, 'vector');


A(1:r, 1:r)  = L(1:r, 1:r) - diag(ones(r, 1)) + U(1:r, 1:r);

if m ~= n
    if r == n
        A(r+1:m,:) = L(r+1:m,:);
    else
        A(:, r+1:n) = U(:, r+1:n);
    end
end

%{
P = (1:m);

for i = 1:1:min(m,n)
   
    [v, index] = max(abs(A(i:m, i)));
    index = index + i - 1; 
    if i ~= index
        t = P(i); % store the original data
        P(i) = P(index); % k position with the new value
        P(index) = t; % rp positon with the original value
        rt = A(i,:); % take the k column out of the 
        A(i,:) = A(index,:); % put the new data into the k column
        A(index,:) = rt; % permute 
    end
    
    rows = (i+1):m;
    cols = (i+1):n;
    A(rows,i) = A(rows,i)/A(i,i);
    A(rows,cols) = A(rows,cols)-A(rows,i)*A(i,cols);
     
end
%}
end


