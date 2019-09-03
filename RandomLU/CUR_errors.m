
%function [errs, times, NZ, L, U] = CUR_errors(A, k, b)

function [errs, times, NZ, L, U] = CUR_errors(A, ss, k, b, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    
    if nargin>4
        mode = 'spec'
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
    end
    
    %[U, S, V] = svd(A);
    errs = [];
    times = [];
    NZ = [];
    LL = [];
    UU = [];
    err = norm(A, 'fro');
    
    for i = ss:b:k
        tic
        [L, U, p_left, p_right, ~] = GERCP(A,'block_size',10, 'over_size',15, 'target_rank', i);
        L = L( TransposePermutation(p_left),:);
        U = U(:,TransposePermutation(p_right));
        iL = pinv(L);
        iU = pinv(U);
        
        times = [times; toc];
        LL = [LL, nnz(L)];
        UU = [UU, nnz(U)];
        NZ =[NZ, nnz(L * U)];
        if strcmp(mode,'spec')
            er = norm(A-L * (iL * A * iU) * U) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-L*(iL * A * iU)* U, 'fro') / err;
            errs = [errs; er];
        end
    end
     %errs = errs /err;
     NZ = [NZ; LL; UU];
     