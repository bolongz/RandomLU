clear;
%X = [1000, 2000, 3000, 4000, 8000, 1000, 16000, 24000];
N = 1000;
X = [100:100:500];

dim = size(X,2);

qr_times = zeros(dim,1);
eigsvd_times = zeros(dim,1);

for i = 1:1:dim
    %A = sprandn(N, X(i), 0.003);
    A = randn(N, X(i));
    %[A, ~] =GenerateMatrix(N,X(i),  X(i));
    for ii = 1:1:20
        tic        
        [Q,R] = svd(A, 0);;
        t1 = toc;
        qr_times(i) = qr_times(i) + t1;
        tic;
        [U, S, V] = eigSVD(A');
        t22 = toc;
        eigsvd_times(i) = eigsvd_times(i) + t22;
    end
end
save('qrandsvd_test_1000.mat');
