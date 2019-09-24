mm = 500;
k = 20;

A = gen_rand_mat_linear_decay(mm,mm, 0.01);
%A = sprandn(500,500,0.01);
%AA = load('adder_dcop_64.mat');
%AA = load('S80PI_n1.mat');
%AA = load('nasa2910.mat');
%A = gen_rand_mat_exp_decay(800,800,10);
%A = full(AA.Problem.A);

size(A)
%s = svds(A,100,'largest', 'MaxIterations',350)


[m,n] = size(A);
%[U, S, V] =  svds(A(:,1:k),k,'largest', 'MaxIterations',350);
%oos = diag(S);
C = A;

Omega = randn(20, m);
RR = Omega * C;
[~,~, ppc_right] = qr(RR(:,1:n), 'vector');
C = C(:, ppc_right);
%[UUCA, SSCA, VVCA] =  svd(C(:,1:k), 'econ');
%as = diag(SA);


CC = C(:, 1:2*k);
[~,~, ppp_right] = qr(CC(:,1:2*k), 'vector');
CC = CC(:, ppp_right);
C = CC;

[UCA, SCA, VCA] =  svd(C(:,1:k), 'econ');
aacs = diag(SCA);

B = A;
[~,~, pp] = qr(B(:,1:n), 'vector');
B = B(:, pp);



[UB, SB, VB] =  svd(B(:,1:k), 'econ');
os = diag(SB);
size(os)

Omega = randn(20, m);
R = Omega * A;
[~,~, pp_right] = qr(R(:,1:n), 'vector');
A = A(:, pp_right);

[UUA, SSA, VVA] =  svd(A(:,1:k), 'econ');
as = diag(SA);


AA = A(:, 1:2*k);
[~,~, ppp_right] = qr(AA(:,1:2*k), 'vector');
AA = AA(:, ppp_right);
A = AA;

[UA, SA, VA] =  svd(A(:,1:k), 'econ');
aas = diag(SA);

X = 1:k;
plot(X, os, '--rx', X,as ,'-.ko', X, aas , '-.b+', X, aacs , '-.g+')







