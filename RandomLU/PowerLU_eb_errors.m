
function errs = PowerLU_eb_errors(A, ss, k, b,p, mode)
 
    if strcmp(mode,'spec')
        mode = 'spec';
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    errs = [];
    
    for i = ss:b:k
        [ L, U] = PowerLU_eb_k(A,i, i,b, p);
        if strcmp(mode,'spec')
            er = norm(A-L * U) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
 