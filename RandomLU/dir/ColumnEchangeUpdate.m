function [L, U, P, Q] = ColumnEchangeUpdate(L, U, P, Q, col, vec)

%Input: PLUQ = 
%Updated L, U for column change
%col: index needed to be replaced
%vec: new column data
%L, U, P, Q: are the current LU decomposition data.
%%  Reference: Gondzio, J. "Stable algorithm for updating dense LU factorization after
%%  row or column exchange and row and column addition or deletion". 
%%  Optimization 23.1 (1992): 7-26. 
 
[m,~] = size(L);
[~,n] = size(U);

new_vec = L\(LeftPermMat(P)' * vec); 
ep = zeros(n,1);
ep(col) = 1;
p_u = find(ep(Q)); % find the position in U. P12-13 from the paper
q = find(new_vec, 1, 'last'); % the length of the new vector represented in U. NEW POSITION

U(:, p_u) = new_vec;

QQ = [1:p_u-1, p_u+1:q-1, p_u,q:n];
U = U(:,QQ);
Pn = [1:m]; % New row permutation 
Qn = [1:n]; % New col permutation 

for i = p_u:q-1
    
    Hi = U(i:i+1, i:i+1);    
    Li = L(i:i+1, i:i+1);
    
    
    QQi = diag([1,1]); %
    PPi = diag([1,1]); %
    Mi = diag([1,1]); % Matrix M 
    Mii = diag([1,1]); % inverse of M 
    
    z = Li(2,1);
    a = Hi(1,1);
    b = Hi(2,1);
    
    if abs(b/a) * 0.1 < 1     
        Mi(2,1) = -b/a; 
        Mii(2,1) = b/a; 
    else
        vv = ( 1 + (b/a)^2) - (z^2 + (a^2 + b^2)/((a * z + b)^2))
        v = a * z + b;
        if vv < 0
            Mi(2,1) = -b/a; 
            Mii(2,1) = b/a; 
            
        else
            Pn = Pn(:,[1:i-1, i+1,i, i+2:n]); % permutation 
            L = L([1:i-1,i+1, i, i+2:m],:); % Row Permutation
            PPi = PPi';
            Mi(1,1) = z; 
            Mi(2,1) = b / v;
            Mi(1,2) = 1;
            Mi(2,2) = - a/v;
            
            Mii(1,1) = a/v; 
            Mii(2,1) = b/v;
            Mii(1,2) = 1;
            Mii(2,2) = -z;
        end
    end
   
   
    L(i:m, i:i+1) = L(i:m, i:i+1) * Mii;
    U(i:i+1, i:n) = Mi * U(i:i+1, i:n)
  
end
P = P(TransposePermutation(Pn));
QQ = TransposePermutation(QQ);
Qn = TransposePermutation(Qn);
QQQn = Qn(QQ);
Q = Q(QQQn);

