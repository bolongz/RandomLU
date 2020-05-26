clear all
readImage;

% test PowerLU_eb
tic; [L1, U1, k]= RandLU_b(A,200, 10, 0); toc
k
tic; [L, U,  k]= RandLU_b(A,200, 20, 0); toc
k
tic; [L, U, k]= RandLU_b(A,, 10, 1); toc
k
tic; [L, U,  k]= RandLU_b(A,1e-1, 20, 1); toc
k