function Q=RightPermMat(v)
%RIGHTPERMMAT Converts a right permutation matrix represented as vector 
% back into a matrix
    I = eye(length(v));
    Q = I(:,v);
end

    
    