function [ L, U, P1, P2, fk] = PowerLU_FP(A,relerr,q, maxcol)
%RANDOMIZEDLU Performs randomized LU Decomposition up to a given rank
%   Parameters:
%   A - matrix to be factorized.
%   k - desired rank of the L*U approximation. i.e. rank(L*U).
%   l - number of random projections to use (should be slightly bigger
%   than k)
%   q - number of power iterations to perform (small integer) for
%   improved accuracy on the account of speed. Default is q=0.
%   mode - full or 'econ'. Default is economy.
%   gpu - boolean for indicating whether to run on GPU. If true, A should
%   be already on the GPU.
%   P1,P2 - permutation matrices, represented as vectors.
%   The approximation error is given by A(P1,P2)-L*U


[m, n]=size(A);
b = 10;
if nargin<3,
    maxcol= 200;    % for precalculating a large number of random vectors.
end
tic
L =zeros(m,maxcol);
U = zeros(maxcol,n);
flag = false;
acc= relerr^2*(norm(A, 'fro')^2);%/(10*sqrt(2/pi))
%acc= relerr*norm(A);
P2 = [];
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
%G = A * VV;

i = 1;
E = 10000000000;
k = 0;

while E > acc && i * b < maxcol,
    %if i >1 
    %    [L1, U1] = lu(G(:, (i-1) * b + 1 : i*b) - L(:, 1:(i-1) * b) * U(1:(i-1) * b, :)* VV(:, (i-1) * b + 1 : i*b));
    %else
    [L1, U1] = lu(A * VV(:, (i-1) * b + 1 : i*b));
    %end
    L(:, (i-1) * b + 1: i *b) = L1; 
    U((i-1) * b + 1: i *b, :) =  U1 * VV(:, (i-1) * b + 1 : i*b)';
    A_ = A -  L(:, (i-1) * b + 1: i *b) * U((i-1) * b + 1: i *b, :);
    E = norm(A_, 'fro')^2;
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
end

%{
while E > acc && i * b < maxcol,
    if i >1 
        [L1, U1] = lu(G(:, (i-1) * b + 1 : i*b) - L(:, 1:(i-1) * b) * U(1:(i-1) * b, :)* VV(:, (i-1) * b + 1 : i*b));
    else
        [L1, U1] = lu(G(:, (i-1) * b + 1 : i*b));
    end
    L(:, (i-1) * b + 1: i *b) = L1; 
    U((i-1) * b + 1: i *b, :) =  U1 * VV(:, (i-1) * b + 1 : i*b)';
    A_ = A -  L(:, (i-1) * b + 1: i *b) * U((i-1) * b + 1: i *b, :);
    E = norm(A_, 'fro')^2;
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
end
%}

if E > acc
    fprintf('Warning: the accuracy is not attained with the maximum iteration: %d', maxcol);
end
 
fk = k;
P1=[];
P2=[];
%{
[LL, UU, P1] = lu(L, 'vector');
[U,Lb,P2] = lu(U' * UU','vector');
L = LL*Lb';
U = U';
%}
end