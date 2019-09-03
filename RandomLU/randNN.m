function ss = randNN(A,b,q)
m = size(A,1); n = size(A,2);
ss = zeros(n,1);
T = A;
for i=1:ceil(n/b)
I1 = (b*(i-1)+1):min((b*i),n);
I2 = (b*i+1):m;
J1 = (b*(i-1)+1):min((b*i),n);
J2 = (b*i+1):n;
if isempty(J2) == 0
T_work = T([I1 I2],[J1 J2]);
[TT,ss_part] = step_nn(T_work,b,q);
ss(I1) = ss_part;
T([I1 I2],[J1 J2]) = TT;
else
ss_part = svd(T(I1,J1));
ss(I1) = ss_part;
end
end
return