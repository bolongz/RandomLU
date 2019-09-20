
function errs = randSVD_errors(A, ss, k, b,p, mode)
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
        [U,S,V] = basicQB_svd(A, i + 5, i, p);
        if strcmp(mode,'spec')
            er = norm(A-U*S*V')/eigs(1); 
            errs = [errs; er];
        else
            er = norm(A-U*S*V', 'fro') / err;
            errs = [errs; er];
        end
    end
  