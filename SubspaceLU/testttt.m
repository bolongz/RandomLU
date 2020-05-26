tic
L = [];
for k = 1:20;
   L = [L, randn(1000, 10)];
end
toc

tic
L = zeros(1000,200);

for k = 1:20
 
    L(:, (k-1) * 10 + 1:k*10) = randn(1000, 10);

end
toc
