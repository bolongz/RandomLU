blocks = [10:10:200];
[m,n] = size(blocks);

r1 = 200;
r2 = 400;
M1 = randn(3000,3000);

res_200 = zeros(n,1);
res_400 = zeros(n,1);
for j = 1:n
    b = blocks(j);
    for i=1:20
        tic;
        [~, ~] = PowerLU_eb_km(M1,200, 200,b,2);
        tt = toc;
        res_200(j) = res_200(j) + tt;
        
        tic;
        [~, ~] = PowerLU_eb_km(M1,400, 400,b,2);
        tt1 = toc;
        res_400(j) = res_400(j) + tt1;
    end
end
    
M2 = randn(2000, 6000);
res2_200 = zeros(n,1);
res2_400 = zeros(n,1);
for j = 1:n
    b = blocks(j);
    for i=1:20
        tic;
        [~, ~] = PowerLU_eb_km(M2,200, 200,b,2);
        tt21 = toc;
        res2_200(j) = res2_200(j) + tt21;
        
        tic;
        [~, ~] = PowerLU_eb_km(M2,400, 400,b,2);
        tt22 = toc;
        res2_400(j) = res2_400(j) + tt22;
    end
end

M3 = randn(6000, 2000);
res3_200 = zeros(n,1);
res3_400 = zeros(n,1);
for j = 1:n
    b = blocks(j);
    for i=1:20
        tic;
        [~, ~] = PowerLU_eb_km(M3,200, 200,b,2);
        tt31 = toc;
        res3_200(j) = res3_200(j) + tt31;
        
        tic;
        [~, ~] = PowerLU_eb_km(M3,400, 400,b,2);
        tt32 = toc;
        res3_400(j) = res3_400(j) + tt32;
    end
end
save('blocks_CPU.mat') 