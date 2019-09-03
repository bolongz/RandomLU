%A = gen_rand_mat_s_decay(1000,800, 7);
%A = gen_rand_mat_slow_decay(1000,800, 5);
A = gen_rand_mat_exp_decay(1000,800,5);%
kk = 400;
ss = 10;
step = 10;
X = [ss:step:kk];
p = 2;
mode = 'spec';
dim = size(X,2);
power_err = zeros(1, dim);
power_time = zeros(1, dim);
rlu_err = zeros(1, dim);
rlu_time = zeros(1,dim);
for i = 1:20
    [powerlu_errs, powerlu_times] = PowerRandLU_errors(A,ss,kk,step,6, mode);
    power_err = power_err + powerlu_errs;
    power_time = power_time + powerlu_times;
    [RandLU_errs, RandLU_times] = RandLU_errors( A,ss,kk,step, p, mode);
    rlu_err = rlu_err + RandLU_errs;
    rlu_time = rlu_time + RandLU_times;
end
[svd_err, svd_time] = SVD_errors(A, ss, kk, step,mode);

%[randqb_errs, randqb_times] = randSVD_errors(A, ss, kk, step, p,mode);

%profile report
subplot(1,2,1);
semilogy(X, svd_err, '--rx' , X, power_err/20, '-c<',X, rlu_err/20, '-.k*' ,'LineWidth', 2, 'MarkerSize', 6);
legend( 'SVD errors', 'PowerLU errors', 'RandLU errors');

subplot(1,2,2);
semilogy(X, svd_time, '--rx', X, power_time/20, '-c<',X, rlu_time/20, '-.k*', 'LineWidth', 2, 'MarkerSize', 6);
legend('SVD Times',  'PowerLU times', 'RandLU times');
%{
subplot(1,2,1);
semilogy(X, svd_errs, '--rx' , X, randqb_errs, ':g+', X, powerlu_errs, '-c<',X, RandLU_errs, '-.k*' ,'LineWidth', 2, 'MarkerSize', 6);
legend( 'SVD errors',  'RandSVD errors', 'PowerRandLU errors', 'RandLU errors');

subplot(1,2,2);
semilogy(X, svd_times, '--rx',X, randqb_times, ':g+',X, powerlu_times, '-c<',X, RandLU_times, '-.k*', 'LineWidth', 2, 'MarkerSize', 6);
legend('SVD Times', 'Rand SVD Times',  'PowerRandLU times', 'RandLU times');
%}
%subplot(1,3,3)
%plot(X, svd_errs-svd_errs, '--rx' , X, randqb_errs-svd_errs, ':g+', X, powerlu_errs-svd_errs, '-c<',X, RandLU_errs-svd_errs, '-.k*', 'LineWidth', 2, 'MarkerSize', 6);
%legend( 'SVD errors',  'Rand QB errors', 'PowerRandLU errors', 'RandLU errors');
%AA = load('adder_dcop_64.mat');
%AA = load('S80PI_n1.mat');
%AA = load('nasa2910.mat');%
%A = AA.Problem.A;
