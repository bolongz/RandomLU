
function errs = PowerLU_b_errors(A, ss, k, b,p, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    
     if strcmp(mode,'spec')
        mode = 'spec';
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    errs = [];
    err = norm(A, 'fro');
    
    for i = ss:b:k
        [ L, U] =  PowerLU_eb_k(A,i + 5, i,10,4);
        if strcmp(mode,'spec')
            er = norm(A-L * U) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A- L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
     %errs = errs /err;
     %NZ = [NZ; LL; UU];
   