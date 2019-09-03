
function [errs, times, Q, R] = QRCP_errors(A, ss, k, b, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    
    if nargin>4
        mode = 'spec'
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
    end
    
    %[U, S, V] = svd(A);
    errs = [];
    times = [];
    NZ = [];
    LL = [];
    UU = [];
    err = norm(A, 'fro');
    for i = ss:b:k
        tic
        [Q, R,pp] = qr(A, 'vector');
        times = [times; toc];
        A = A(:,pp);
         if strcmp(mode,'spec')
            er = normest(A-Q(:,1:i) * R(1:i,:)) / eigs(1); 
            errs = [errs; er];
        else
            er = norm(A - Q(:,1:i) * R(1:i,:), 'fro') / err;
            errs = [errs; er];
        end
    end
     %errs = errs /err;
    % NZ = [NZ; LL; UU];
     