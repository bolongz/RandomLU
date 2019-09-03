
function [errs, times] = PowerRandLU_errors(A, ss, k, b,p, mode)
 
    if nargin>5
        mode = 'spec';
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    errs = [];
    times = [];
    
    for i = ss:b:k
        tic        
        [ L, U, p_left, p_right] = PowerRandLU(A,i+3, i,p);
        times = [times; toc];
        L = L( TransposePermutation(p_left),:);
        U = U(:,TransposePermutation(p_right)); 
        if strcmp(mode,'spec')
            er = norm(A-L * U) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
 