
n= 8000;
M1= genTestMatrix(n, n, 1);
M2= genTestMatrix(n, n, 2);
M3= genTestMatrix(n, n, 3);

% test Adpative Range Finder.

[Q, B, k]= AdpRangeFinder(M1, 1e-2); k
 [Q, B, k]= AdpRangeFinder(M1, 1e-4); k
 [Q, B, k]= AdpRangeFinder(M2, 1e-4); k
 [Q, B, k]= AdpRangeFinder(M2, 1e-5); k

 [Q, B, k]= AdpRangeFinder(M3, 1e-2); k
 [Q, B, k]= AdpRangeFinder(M3, 1.5e-3, 7950); k

% test SubspaceLU_FP
tic; [L, U, P1, P2, k]= SubspaceLU_FP(M1,1e-2, 10, 4); toc
k
tic; [L, U, P1, P2, k]= SubspaceLU_FP(M1,1e-4, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(M2,1e-4, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(M2,1e-5, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(M3,1e-2, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(M3,1.5e-3, 40, 4); toc
k

% test randQB_FP
tic; [Q, B, k]= randQB_FP_auto(M1, 1e-2, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(M1, 1e-4, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(M2, 1e-4, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(M2, 1e-5, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(M3, 1e-2, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(M3, 1.5e-3, 40, 1); toc
k

%SVD
k = truncated_svd(M1, 1e-2)
k = truncated_svd(M1, 1e-4)
k = truncated_svd(M2, 1e-4)
k = truncated_svd(M2, 1e-5)
k = truncated_svd(M3, 1e-2)
k = truncated_svd(M3, 1.5e-3)

%SVD
%{
tic;
[U1, S1, V1] = svd(M1);
toc
flag = true;
flag2 = true;
E1 = norm(M1, 'fro')^2;
err1 = (1e-2)^2 * E1;
err2 = (1e-4)^2 * E1;

for i = 1:1:n-1
    sum1 = 0;
    for j = i+1:1:n
        sum1 = sum1+S1(j,j)^2;
        if sum1 < err2
            i
            flag2 = true;
            break; 
        end
        if (sum1 < err1) && flag
            i
            flag = false;
        end
        
    end
    if flag2
        break;
    end
end

%}


%{   
tic;
[U2, S2, V2] = svd(M2);
toc
flag  = true;
flag2 = false;
E2 = norm(M2, 'fro')^2;
err1 = (1e-4)^2 * E2;
err2 = (1e-5)^2 * E2;

for i = 1:1:n-1
    sum2 = 0;
    for j = i+1:1:n
        sum2 = sum2+S2(j,j)^2;
        if sum2 < err2    %[L1, U1] = lu(G(:, t1 + 1 : t2) - L(:, 1:t1) * (U(1:t1, :)* VV(:, t1 + 1 : t2)));

            i
            flag2 = true;
            break; 
        end
        if (sum2 < err1) && flag
            i
            flag = false;
        end
        
    end
     if flag2
        break;
    end
end
    
tic;
[U3, S3, V3] = svd(M3);
toc
flag = true;
flag2 = false;
E3 = norm(M3, 'fro')^2;
err1 = (1e-2)^2 * E3;
err2 = (1.5e-3)^2 * E3;

for i = 1:1:n-1
    sum3 = 0;
    for j = i+1:1:n
        sum3 = sum3+S3(j,j)^2;
        if sum3 < err2
            i
            flag2  = true;
            break; 
        end
        if (sum3 < err1) && flag
            i
            flag = false;
        end
        
    end
     if flag2
        break;
    endpowerr2
end
  %}  
%{
clear all;
readImage;
[Q, B, k]= AdpRangeFinder(A, 0.1); k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 10, 1); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 20, 1); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 10, 2); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 20, 2); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1powerr2, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1, 20, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1, 10, 2); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1, 20, 2); toc
k


clear all;
loadAminerMatrix;
% [Q, B, k]= AdpRangeFinder(A, 0.5, 8100); k
tic; [Q, B, k]= randQB_EI_auto(A, 0.5, 50, 1); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.5, 50, 2); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.5, 50, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.5, 50, 2); toc
k

%}
