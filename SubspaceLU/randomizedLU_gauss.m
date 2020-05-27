function [ L, U, P1, P2] = randomizedLU_gauss( A,l,k,q,mode, gpu, density)
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

if nargin==3
    q=0;
    mode = 'econ';
    gpu = false;
    density=1;
elseif nargin==4
    mode = 'econ';
    gpu = false;
    density=1;
elseif nargin==5
    mode = 'econ';
    gpu = false;
    density=1;
elseif nargin==6
    density=1;
end

pinvmode = 'gauss';
%pinvmode = 'regular';
if gpu
    pinvmode = 'gpu';
end

[n, m]=size(A);
l = min([l m n]);
if gpu
    Omega = gpuArray.randn(m,l);
    A = gpuArray(A);
    if density<1
        Omega = Omega.*(gpuArray.*rand(m,l)<density)/density;
    end
else
    Omega = randn(m,l);
    if density<1
        Omega = Omega.*(rand(m,l)<density)/density;
    end
        
end

Y= A*Omega;

%{
if q>0
    for ii = 1:q
        Y=A*(A'*Y);
    end
end
%}
[Ly,~, Py]  = lu(Y, 'vector');  
if q>0
    Ly = Ly( TransposePermutation(Py),:);
    for ii = 1:q
        [Ly, ~] = lu(A' * Ly);
        if ii == q
            %[Y, ~] = qr(A * Y, 0); 
            [Ly,~, Py]  = lu(A * Ly, 'vector');  
        else
            [Ly, ~] = lu(A * Ly);
        end
    end
end
%else
%    [Ly,~, P1]  = lu(Y, 'vector');
%end

% [Ly, ~, Py] = lu(Y,'vector');
if l>k
    Ly = Ly(:,1:k);
end
invL = Fastpinv(Ly,pinvmode);
if gpu
    A = gather(A);
    B = invL * A(Py,:);
    A = gpuArray(A);
else
    B = invL*A(Py,:);
end
[Lb, Ub, Pb] = LU_Col(B','regular');
L = Ly*Lb;
U = Ub;
P1=Py;
P2=Pb;
if strcmp(mode,'full')
    L = [L zeros(n,n-k)];
    U = [U; zeros(n-k,m)];
end

if gpu
    L = gather(L);
    U = gather(U);
    P1 = gather(P1);
    P2 = gather(P2);
end
end
