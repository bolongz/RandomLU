function [L,U,P] = LU_Col(A,mode)
%LU_Col performs LU decompositions with column pivoting
%   such that AP=LU
%   A - matrix to factorize.
%   L,U - Lower and upper matrices, respectively.
%   P - Matrix permutation represented as vector.

    if nargin<2
        mode = 'regular';
    end
    
    %A=A';
    [l,u,P] = lu(A,'vector');
    L = u';
    U = l';
    %P = p';
    
    if strcmp(mode, 'unitdiag')
        D = diag(L);
        b = find(D>1e-10);
        D(b) = 1./D(b);
        D = diag(D);
        L = L*D;
        U = D*U;
    elseif strcmp(mode, 'normalize')
        D = diag(sqrt(sum(L.^2)));
        L = L*pinv(D);
        U = D*U;
    end
    
    
end
