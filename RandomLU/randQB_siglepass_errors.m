
function errs = randQB_siglepass_errors(A, ss, k, b, mode)
 
    if strcmp(mode,'spec')
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
        %[Q, B, Qt]= singlePass2011(A,i,b);
        [Q, B, ~] = randQB_FP_k(A, i, b, 0);
        if strcmp(mode,'spec')
            er = norm(A- Q*B) / eigs(1); 
            errs = [errs; er];
        elseif strcmp(mode, 'fro')
            er = norm(A- Q*B, 'fro') / err;
            errs = [errs; er];
        else
            er = norm(A- Q*B); 
            errs = [errs; er];
        end
    end
 