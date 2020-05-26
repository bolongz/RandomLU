clear
figure(1);
C = randn(1000, 1000);
C1 = randn(1000, 1000);
C2 = randn(1000, 1000);
C3 = randn(1000, 1000);
subplot(1, 2,1);
plot([1:1:100], sin([1:1:100]));
subplot(1, 2,2);
plot([1:1:100], sin([1:1:100]));
save('fig1.mat');