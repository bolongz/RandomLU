function [ L, U, k] = RandLU_fpp(A,relerr, b, p)
E = norm(A, 'fro')^2;
acc= relerr^2*E;

[m,n]=size(A);


L = [];
U = [];
Lp = [];
k = 0;
flag = false;
while 1
    Omg = randn(n, b);
    [Li, ~] = lu(A * Omg);
    for j= 1:1:p
        [Li, ~] = lu(A' * Li);
        [Li, ~] = lu(A * Li);
    end
    %{
    if k > 0
        [Li, ~] = lu(Li - L * Lp * Li);
    end
    Lip = Fastpinv(Li, 'gauss');
    Ui = Lip * A;
    L = [L, Li];
    U = [U;Ui];
    Lp = [Lp; Lip];
    %}
    Ui = Fastpinv(Li, 'gauss') * A;
    L = [L, Li];
    U = [U;Ui];
    
    %temp = A;
    A = A - Li * Ui;
    k = k + b;
    if norm(A, 'fro')^2 < acc
        %A = temp;
        k
        flag= true;

        for j=b:-1:1,
            A = A + Li(:,j) * Ui(j,:);
            if norm(A, 'fro')^2 >= acc,
                break;
            end
        end
    else
   
    if flag,
        k= k + (b-j);
        break;
    end
end
end
