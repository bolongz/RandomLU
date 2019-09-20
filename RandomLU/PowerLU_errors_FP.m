
function [errs, L, U] = PowerLU_blocked_errors(A, ss, k, b,p, mode)
% [errs, Q, B] = SVD_errors(A, k, b)
% Using standard svd to get the optimal approximation error.
% k is the rank parameter, b is rank-increase step (usually a factor of k).
% errs is the approximation error in Frobenius norm.

    
     if strcmp(mode,'spec')
        mode = 'spec';
        [~, S, ~] = svds(A, k+1);
        eigs = diag(S);
    else
        mode = 'fro';
        err = norm(A, 'fro');

    end
    
    %[U, S, V] = svd(A);
    errs = [];
    %NZ = [];
    %LL = [];
    %UU = [];
    err = norm(A, 'fro');
    
    for i = ss:b:k
 
        %[L, U, p_left, p_right, ~] = GERCP(A,'block_size',10, 'over_size',15, 'target_rank', i);
        [ L, U, p_left, p_right] =  PowerLU_FP_k(A,i,10,4);
       
        %L = L( TransposePermutation(p_left),:);
        %U = U(:,TransposePermutation(p_right));
        %LL = [LL, nnz(L)];
        %UU = [UU, nnz(U)];
        %NZ =[NZ, nnz(L * U)];
        
        if strcmp(mode,'spec')
            er = norm(A-L * U) / eigs(1); 
            errs = [errs; er];
        else
         
            er = norm(A- L * U, 'fro') / err;
            errs = [errs; er];
        end
    end
     %errs = errs /err;
     %NZ = [NZ; LL; UU];
   