function pinvA = Fastpinv(A, mode)
%FASTPINV Computes the pseudo-inverse of a matrix using different methods
%   A - Matrix for the pseudo inverse
%   mode - determines what algorithm to use for the pseudo inversion
%       'regular' - Compute pinv using SVD
%       'sparse' - Compute inv(A'*A)*A', appropriate for sparse matrices
%       'multpinv' - Same as 'sparse' except it uses pinv instead (doesn't
%       work with sparse representations)
%       'gpu' - Same like 'sparse' but compatible to GPUs
%       'gauss' - Uses Gauss elimination for the inverse.
if nargin<2
    mode = 'regular';
end

if strcmp(mode, 'regular')
    [u,s,v]=svd(A,'econ');
    pinvA = v*pinv(s)*u';
elseif strcmp(mode, 'sparse')
    pinvA = inv(A'*A)*A';
elseif strcmp(mode, 'multpinv')
    pinvA = pinv(A'*A)*A';
elseif strcmp(mode,'gpu')
    pinvA = ((A'*A)\(gpuArray(double(eye(size(A,2))))))*A';
elseif strcmp(mode, 'gauss')
    pinvA = ((A'*A)\(eye(size(A,2))))*A';
end

end

    
    
    

    