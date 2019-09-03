function [errs, times,  Q, B] = SVD_errors(A, ss, k, b, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    if nargin>4
        mode = 'spec';
        tic
        [~, S, ~] = svds(A, k);
        time = toc;
        eigs = diag(S);    
        Q = [];
        B = [];
    else  
        mode = 'fro';
        err = norm(A, 'fro');
    end
    
    errs = [];
    times = [];
    
    for i = ss/b:k/b
        if strcmp(mode,'spec')
            er = eigs(i * b); 
            errs = [errs; er];
            times = [times; time];
        else
            tic
            [Q, S, V] =  svds(A, i*b);
            times = [times; toc];
            B = S * V';
            er = norm(A-Q*B, 'fro') / err;
            errs = [errs; er];
        end
    end