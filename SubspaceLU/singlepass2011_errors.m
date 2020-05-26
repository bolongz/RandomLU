
function errs = singlepass2011_errors(A, ss, k, b, mode)
 
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
        [Q, B, Qt]= singlePass2011(A,i,b);
        if strcmp(mode,'spec')
            er = norm(A- Q*B*Qt') / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A- Q*B*Qt', 'fro') / err;
            errs = [errs; er];
        end
    end
 