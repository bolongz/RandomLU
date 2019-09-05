function errs = SVD_errors(A, ss, k, b, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    if nargin>4
        mode = 'spec';
        tic
        [~, S, ~] = svds(A, k + 5);
        eigs = diag(S);    
    else  
        mode = 'fro';
        err = norm(A, 'fro');
    end
    
    errs = [];
    for i = ss/b:k/b
        if strcmp(mode,'spec')
            er = eigs(i * b + 1)/eigs(1); 
            errs = [errs; er];
        else
            [Q, S, V] =  svds(A, i*b);
            er = norm(A-Q*B, 'fro') / err;
            errs = [errs; er];
        end
    end