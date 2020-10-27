function errs = SVD_errors(A, ss, k, b, mode)

    if strcmp(mode,'spec')
        [U, S, V] = svd(full(A));
        %[~, S, ~] = svds(A, k + 5);
        eigs = diag(S);    
    else  
        mode = 'fro';
        [U, S, V] = svd(full(A));
        err = norm(A, 'fro');
    end
    
    errs = [];
    for i = ss/b:k/b
        if strcmp(mode,'spec')
            Q = U(:, 1:i*b);
            B = S(1:i*b, 1:i*b) * V(:, 1:i*b)';     
            errs = [errs; norm(A-Q*B)/eigs(1)];
        else
            Q = U(:, 1:i*b);
            B = S(1:i*b, 1:i*b) * V(:, 1:i*b)';
            er = norm(A-Q*B, 'fro') / err;
            errs = [errs; er];
        end
    end