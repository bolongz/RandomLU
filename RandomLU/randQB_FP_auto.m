function [Q, B, k] = randQB_FP_auto(A, relerr, b, P)
% [Q, B, k] = randQB_FP_auto(A, relerr, b, P)
% The fixed-precision randQB_FP algorithm.
% It produces QB factorization of A, whose approximation error fulfills
%     ||A-QB||_F <= ||A||_F* relerr.
% b is block size, P is power parameter.
% Output k is the rank.

    [m, n]  = size(A);
    Q = zeros(m, 0);
    B = zeros(0, n);

    maxiter= 400;                % this may be changed case by case.
    %maxiter= min(maxiter, ceil(min(m,n)/3/b));
 
    % =========
    E= norm(A, 'fro')^2;
    E0= E;
    threshold= relerr^2*E  
    r = 1;
    flag= false;
    
    for i=1:maxiter,
        Omg = randn(n, b);
        Y = A * Omg - (Q * (B * Omg));
        [Qi, ~] = qr(Y, 0);
        
        for j = 1:P        % power scheme
            [Qi, ~] = qr(A'*Qi - B'*(Q'*Qi), 0);  % can skip orthonormalization for small b.
            [Qi, ~] = qr(A*Qi - Q*(B*Qi), 0);
        end
        
        if r>1,            % can skip the first re-orthogonalization
            [Qi, ~] = qr(Qi - Q * (Q' * Qi), 0);
        end
        Bi= Qi'*A;  % another choice is Bi = Qi' * A - Qi' * Q * B;
        
        Q = [Q, Qi];
        B = [B; Bi];
                
        temp = abs(E- norm(Bi, 'fro')^2);
        
        if temp< threshold,     % for precise rank determination 
            for j=1:b,
                E= E-norm(Bi(j,:))^2;
                if E< threshold,
                    flag= true;
                    break;
                end
            end
        else
            E= temp;
        end
        if flag,
            k= (i-1)*b+j;
            break;
        end
    end
    
    if ~flag,
        fprintf('E = %f. Fail to converge within maxiter!\n', sqrt(E/E0));
    end
end
