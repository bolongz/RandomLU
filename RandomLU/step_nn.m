function [T,ss_part] = step_nn(A,b,q)
G = randn(size(A,1),b);
Y = A'*G;
for i=1:q
Y = A'*(A*Y);
end
[V,~] = qr(Y);
T = A*V;
[U,R] = qr(T(:,1:b));
T(:,1:b) = R;
T(:,(b+1):end) = U'*T(:,(b+1):end);
ss_part = svd(R);
return