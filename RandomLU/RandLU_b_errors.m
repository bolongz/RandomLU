
function errs = RandLU_b_errors(A, ss, k, b,p, mode)
 
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
        [ L, U] = RandLU_b(A,i,b, p);
        if strcmp(mode,'spec')
            er = norm(A - L * U) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A - L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
 