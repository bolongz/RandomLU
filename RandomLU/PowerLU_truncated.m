function [L, U, p_left, p_right, target_rank] = PowerLU_truncated(A,relerr, b, q, maxcol)

%profile on
% Crout LU decomposition
% A is a m x n matrix
% return value:
% A: LU decomposition in position
% L: Lower triangle with unit diagonal
% U: Upper triangle


[m,n] = size(A); % store the size of A, m for rows and n for columns

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
acc= relerr^2*(norm(A, 'fro')^2);%/(10*sqrt(2/pi))
G = A * VV;
G1 = G;
[U, ss, V] = svd(G);
ss= diag(ss);
[m,n] = size(G);

Omega = randn(b+5, m);
R = Omega * G;

p_left = (1:m);
p_right = (1:n);
L = zeros(m,min(m,n));
U = zeros(min(m,n),n);
itera = ceil(min(m,n)/b);
for j = 0 : 1 : itera-1
    j = j * b;
    if j + b > n % compute the column boundary 
        col = n;
    else
        col =j + b;
    end  
    % chose the column pivots
    [~,~, pp_right] = qr(R(:, j+1:n), 'vector');
    ppr = [1:j, pp_right + j];
    U = U(:, ppr);
    G = G(:, ppr);
    p_right = p_right(ppr);
    row = j+1 : m; % rows need to compute   
    
    G(row, j+1:col) =  G(row, j+1:col) - L(row, 1:j) * U(1:j,j+1:col); 

    %----------------------------
    % updating the stars parts
    % . . . . . . . . . .
    % . . . . . . . . . .
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * * 
    %----------------------------
    %[T, p_lu] = LU(A(row, j+1: col));  % LU for the above stars part
    
    r = min(m - j, col -j);
    
    [L(row,j+1:j+r), U(j+1:j+r, j+1:col), p_lu] = lu(G(row, j+1:col), 'vector');
 
    pp = [1:j, p_lu + j]; 
    LL = L(:, 1:j);
    L(:,1:j) = LL(pp,:);
    G = G(pp, :);
    %A(row, j+1:col)  = T; % get the new value for the stars 
    p_left = p_left(pp);
    U(j+1:col, col+1: n) = G(j+1:col, col+1:n) - L(j+1:col, 1:j) * U(1:j, col+1:n);
    %L11 = tril(T(1:col-j, 1:col-j), -1) + speye(col-j, col -j);
    U(j+1:col, col+1: n) = L(j+1:col, j+1:col)\ U(j+1:col, col+1:n);

    %Updating # parts 
    % . . . . . . . . . .
    % . . . . . . . . . .
    % . . * * # # # # # #
    % . . * * # # # # # #
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    % . . * *
    %-------------------
    %updating R
    LL = L(TransposePermutation(p_left),:);
    UU = U(:, TransposePermutation(p_right));
    
    norm(G1 - LL(:, 1:col) * UU(1:col, :), 'fro');
    if norm(A - LL(:, 1:col) * UU(1:col, :) * VV', 'fro')^2 < acc
        target_rank = col;
        break;
    end
    R(:,col+1:n) = R(:,col+1:n) - (Omega(:,j+1:col) * L(j+1:j+r, j+1:j+r) + ...
    Omega(:,col+1:m) * L(col+1:m, j+1:col)) * U(j+1:col, col+1:n);    
    
    
end
end
