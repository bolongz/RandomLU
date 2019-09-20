
function errs = RandLU_errors(A, ss, k, b,p, mode)
 
    if strcmp(mode,'spec')
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    errs = [];
    
    for i = ss:b:k
        [L, U, p_left, p_right] = randomizedLU(A,i+3,i,p,'regular');
        L = L( TransposePermutation(p_left),:);
        U = U(:,TransposePermutation(p_right));  
        
        if strcmp(mode,'spec')
            er = norm(A-L * U)/eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
 