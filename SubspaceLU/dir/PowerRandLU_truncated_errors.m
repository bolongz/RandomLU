
function errs = PowerRandLU_truncated_errors(A, ss, n, k, b, p, mode)
 
    if strcmp(mode,'spec')
        mode = 'spec';
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    errs = [];
    [ L, U, p_left, p_right] = PowerRandLU_truncated(A,n,n,p);
    L = L( TransposePermutation(p_left),:);
    U = U(:,TransposePermutation(p_right)); 
    for i = ss:b:k
        
        LL = L(:, 1:i);
        UU = U(1:i, :); 
        if strcmp(mode,'spec')
            er = norm(A-LL * UU) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-LL * UU, 'fro') / err;
            errs = [errs; er];
        end
    end
 