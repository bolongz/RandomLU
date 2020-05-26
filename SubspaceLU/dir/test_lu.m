A = [10,2,3,4,5;6,20,7,8,9;3,4,40,8,9;9,10,20,40,1;1,2,3,4,50];

[m,n] = size(A);
[L, U, P] = lu(A, 'vector');
Q = [1:n];
[LL, UU, PP, QQ] = UpdateLU(L, U, P, Q, 5, [100;3;6;9;10]);

LL = LL(PP,:)
UU = UU(:,QQ)

NEWW = LL * UU

[U, L, Q, P] = UpdateLU(U', L', TransposePermutation(Q),TransposePermutation(P), 5, [100;3;6;9;10], 'row');


L = L(:,P);
U = U(Q,:);

L = L'
U = U'

NEW = L * U

