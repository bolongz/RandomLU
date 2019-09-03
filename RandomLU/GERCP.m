function [L, U, p_left, p_right, target_rank] = GERCP(A,varargin)

%profile on
% Crout LU decomposition
% A is a m x n matrix
% return value:
% A: LU decomposition in position
% L: Lower triangle with unit diagonal
% U: Upper triangle


[m,n] = size(A); % store the size of A, m for rows and n for columns

params = inputParser;
params.addParameter('target_rank', min(m,n)); %default rank is the min(m,n). Full LU decomposition
params.addParameter('block_size',1); % Default block size is 1
params.addParameter('over_size',3); %Oversampling size >= block_size
params.addParameter('tolerance', -1 ); % Tolerance, if tolerance is set the target_rank will be min(m,n)

params.parse(varargin{:});

k = params.Results.target_rank;
b = params.Results.block_size;
p = params.Results.over_size;
tol = params.Results.tolerance; % default tolerance value is -1
target_rank = k;
if k > min(m,n)
    msg = 'Error occurred. input target rank k is too large';
    error(msg)
end


Omega = randn(p, m);
R = Omega * A;
%{
q = 2;
if q>0
    for ii = 1:q
        R=(R * A') * A;
    end
end
%}
p_left = (1:m);
p_right = (1:n);
L = zeros(m,min(m,n));
U = zeros(min(m,n),n);
if tol == -1
    itera = ceil(k / b);
else
    itera = ceil(min(m,n)/b);
end

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
    A = A(:, ppr);
    p_right = p_right(ppr);
    row = j+1 : m; % rows need to compute   
    
    A(row, j+1:col) =  A(row, j+1:col) - L(row, 1:j) * U(1:j,j+1:col); 
    
     flag = 0;
    if tol ~= -1
        for kk = j+1:1:col
            if abs(A(kk, kk)) < tol
                flag = 1;
                break;
            end
        end
        if flag
            target_rank = j + 1;
            break;
        end
    end
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
    
    [L(row,j+1:j+r), U(j+1:j+r, j+1:col), p_lu] = lu(A(row, j+1:col), 'vector');
 
    pp = [1:j, p_lu + j]; 
    LL = L(:, 1:j);
    L(:,1:j) = LL(pp,:);
    A = A(pp, :);
    %A(row, j+1:col)  = T; % get the new value for the stars 
    p_left = p_left(pp);
    U(j+1:col, col+1: n) = A(j+1:col, col+1:n) - L(j+1:col, 1:j) * U(1:j, col+1:n);
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
    R(:,col+1:n) = R(:,col+1:n) - (Omega(:,j+1:col) * L(j+1:j+r, j+1:j+r) + Omega(:,col+1:m) * L(col+1:m, j+1:col)) * U(j+1:col, col+1:n);    
end
%{
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
    A = A(:, ppr);
    p_right = p_right(ppr);
    row = j+1 : m; % rows need to compute   
    
    A(row, j+1:col) =  A(row, j+1:col) - A(row, 1:j) * A(1:j,j+1:col); 
     flag = 0;
    if tol ~= -1
        for kk = j+1:1:col
            if abs(A(kk, kk)) < tol
                flag = 1;
                break;
            end
        end
        if flag
            target_rank = j + 1;
            break;
        end
    end
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
    [T, p_lu] = LU(A(row, j+1: col));  % LU for the above stars part
    pp = [1:j, p_lu + j]; 
    A = A(pp, :);
    A(row, j+1:col)  = T; % get the new value for the stars 
    p_left = p_left(pp);
    A(j+1:col, col+1: n) = A(j+1:col, col+1:n) - A(j+1:col, 1:j) * A(1:j, col+1:n);
    L11 = tril(T(1:col-j, 1:col-j), -1) + speye(col-j, col -j);
    A(j+1:col, col+1: n) = L11\ A(j+1:col, col+1: n);

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
    R(:,col+1:n) = R(:,col+1:n) - (Omega(:,j+1:col) * L11 + Omega(:,col+1:m) * A(col+1:m, j+1:col)) * A(j+1:col, col+1:n);    
end

l = min(m,n);
L = tril(A(1:m,1:l),-1) + speye(m,l);
U = triu(A(1:l,1:n));
%U = [];
%}
%profile report
%profile off

end
