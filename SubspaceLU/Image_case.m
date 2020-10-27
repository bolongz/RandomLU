clear all
readImage;
% test Adpative Range Finder.
%[Q, B, k]= AdpRangeFinder(A, 1e-1); k
 

% test SubspaceLU_FP
tic; [L1, U1,  P11, P22,k]= SubspaceLU_FP(A,1e-1, 10, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(A,1e-1, 20, 4); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(A,1e-1, 10, 6); toc
k
tic; [L, U,  P1, P2,k]= SubspaceLU_FP(A,1e-1, 20, 6); toc
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

L1 = L1(TransposePermutation(P11),:);
U1 = U1(:,TransposePermutation(P22)); 
BB = L1 * U1;
CC = reshape(BB', [4752,3168, 3]);

CC = permute(CC, [2,1,3]);
figure, imshow(CC)

