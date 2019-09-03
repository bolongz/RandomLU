
function [errs, times, L, U] = LLA_RandLU_errors(A, ss, k, b,p, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    
    if nargin>5
        mode = 'spec'
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
    end
    
    %[U, S, V] = svd(A);
    errs = [];
    times = [];
    %NZ = [];
    %LL = [];
    %UU = [];
    err = norm(A, 'fro');
    
    for i = ss:b:k
        tic
        %[L, U, p_left, p_right, ~] = GERCP(A,'block_size',10, 'over_size',15, 'target_rank', i);
        
        [ L, U, p_left, p_right, ~, LL] = randomizedLU(A,i,i,p,'regular');
        times = [times; toc];

        
        B = A;
        BB = B(p_left, :);
        BB = BB(:, p_right);
        B = Fastpinv(LL, 'regular') * BB;
        LL = LL( TransposePermutation(p_left),:);
        B = LL * B;
 
        A = A(:,p_right);       

        %LL = [LL, nnz(L)];
        %UU = [UU, nnz(U)];
        %NZ =[NZ, nnz(L * U)];
        
        if strcmp(mode,'spec')
            %er = norm(A-L * U); 
            er = norm( A-B);
            errs = [errs; er];
        else
            er = norm(A-B, 'fro') / err;
            errs = [errs; er];
        end
    end
     %errs = errs /err;
     %NZ = [NZ; LL; UU];
   