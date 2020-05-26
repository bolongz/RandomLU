% Create random 50 x 40 x 30 tensor with 5 x 4 x 3 core
info = create_problem('Type','Tucker','Num_Factors',[20 15 10],'Size',[100 100 100],'Noise',0.01);
X = info.Data;
nnz(X)
%full(X)

% Compute HOSVD with desired relative error = 0.1
%tic

profile on
tic
T = horlu(X,'ranks',[20,15,10]);
toc
%toc
nnz(T.core);
%L{3};
% Check size of core
coresize = size(T.core)

% Check relative error
relerr = norm(X-full(T))/norm(X)

tic
TT = hosvd(X, norm(X), 'sequential', false,'ranks',[20 15 10]);
toc

coresize_svd  = size(TT.core)

relerr1 = norm(X-full(TT))/norm(X)
%profile report
%profile off

