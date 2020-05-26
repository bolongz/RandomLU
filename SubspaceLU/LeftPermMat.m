function P=LeftPermMat(v)
%LEFTPERMMAT Converts a left permutation matrix represented as vector 
% back into a matrix
    I = eye(length(v));
    P = I(v,:);
end

    
    