clear all
readImage;
% test Adpative Range Finder.
 [Q, B, k]= AdpRangeFinder(A, 1e-1); k
 

% test PowerLU_eb
tic; [L1, U1,  P11, P22,k]= PowerLU_eb(A,1e-1, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= PowerLU_eb(A,1e-1, 20, 4); toc
k
tic; [L, U,  P1, P2,k]= PowerLU_eb(A,1e-1, 10, 6); toc
k
tic; [L, U,  P1, P2,k]= PowerLU_eb(A,1e-1, 20, 6); toc
k

% test randQB_FP
tic; [Q, B, k]= randQB_FP_auto(A, 1e-1, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 1e-1, 20, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 1e-1, 10, 2); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 1e-1, 20, 2); toc
k

%SVD
k = truncated_svd(A, 1e-1)

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
        sum2 = sum2+S2(j,j)^2;Elapsed time is 2.421500 seconds.

k =

    66

Elapsed time is 2.433959 seconds.

k =

    82

        if sum2 < err2
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
err1 = (1e-2)^2 * E3;Elapsed time is 2.421500 seconds.

k =

    66

Elapsed time is 2.433959 seconds.

k =

    82

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
        
    endL = L( TransposePermutation(P1),:);
        U = U(:,TransposePermutation(P2)); 
     if flag2
        break;
    end
end
  %}  
%{
clear all;
readImage;
[Q, B, k]= AdpRangeFinder(A, 0.1); k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 10, 1); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1L = L( TransposePermutation(P1),:);
        U = U(:,TransposePermutation(P2)); , 20, 1); toc
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 10, 2); tocL = L( TransposePermutation(P1),:);
        U = U(:,TransposePermutation(P2)); 
k
tic; [Q, B, k]= randQB_EI_auto(A, 0.1, 20, 2); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1, 10, 1); toc
k
tic; [Q, B, k]= randQB_FP_auto(A, 0.1, 20, 1); toc
kElapsed time is 2.421500 seconds.

Elapsed time is 2.449438 seconds.

k =

    16

Elapsed time is 2.769952 seconds.

k =
L = L( TransposePermutation(P1),:);
        U = U(:,TransposePermutation(P2)); 
   328
k =

    66

Elapsed time is 2.433959 seconds.

k =

    82
L = L( TransposePermutation(P1),:);
        U = U(:,TransposePermutation(P2)); 
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

L1 = L1(TransposePermutation(P11),:);
U1 = U1(:,TransposePermutation(P22)); 
BB = L1 * U1;
CC = reshape(BB', [4752,3168, 3]);

CC = permute(CC, [2,1,3]);
figure, imshow(CC)

