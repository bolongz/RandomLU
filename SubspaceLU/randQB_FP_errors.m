
function [rank, times,  Q, B] = randQB_FP_errors(A, ss, k, b,p, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    if nargin>5
        mode = 'spec'
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
    end
    
    errs = [];
    times = [];
 
    err = norm(A, 'fro');
    for i = ss:b:k
        tic
        [Q, B, k] = randQB_EI_k(A, i, 5, p);
        times = [times; toc];
       
        if strcmp(mode,'spec')
            er = norm(A-Q*B); 
            errs = [errs; er];
        else
            er = norm(A-Q*B, 'fro') / err;
            errs = [errs; er];
        end
        %errs = [errs; norm(A-Q*B, 'fro')];
    end
     %errs = errs /err;
     %NZ = [NZ; QQ; BB];
     