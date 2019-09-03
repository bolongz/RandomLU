function w = TransposePermutation(v)
%TransposePermutation Converts a permutation matrix represented by a vector
%v into a vector representing the transpose of this permutation matrix
L = length(v);
w = zeros(L, 1);
w(v) = 1:1:L;
end
