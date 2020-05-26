
function errs = randQB_bno_errors(A, ss, k, b,p, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    if strcmp(mode, 'spec')
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
        [Q, B] = randQB_b_kno(A, i, 10, p);
        times = [times; toc];
       
        if strcmp(mode,'spec')
            er = norm(A-Q*B)/eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-Q*B, 'fro') / err;
            errs = [errs; er];
        end
        %errs = [errs; norm(A-Q*B, 'fro')];
    end
     %errs = errs /err;
     %NZ = [NZ; QQ; BB];
     