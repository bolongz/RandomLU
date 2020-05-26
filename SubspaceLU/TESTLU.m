
%% read image
imname= 'Original.jpg';
X= imread(imname);
X= double(X)/255;
%image(X)
X = rgb2gray(X);
%dd = ndims(X)
size(X)
if ndims(X) == 3
   %image(X)
   [m,n,p]= size(X);
   if m>n,
       A= [X(:,:,1), X(:,:,2), X(:,:,3)]; 
   else
       A= [X(:,:,1); X(:,:,2); X(:,:,3)]; 
   end
else
   image(255*X);
   colormap(gray(256));
   A= X;
end
%axis image
%axis off
%drawnow
%clear X;
size(A)
%I = double(imread('dog.jpg'));
%size(I)
desired_rank = 200;
[L, U, p_left, p_right, target_rank] = GERCP(A,'block_size',10, 'over_size',15, 'target_rank', 200);
P_Transpose = TransposePermutation(p_left);
Q_Transpose = TransposePermutation(p_right);
Reconstructed = L(P_Transpose,:)*U(:,Q_Transpose);
%R = reshape(Reconstructed, [419, 559, 3]);

%figure; imagesc(I); axis image; colormap gray
%figure; imagesc(Reconstructed); axis image; colormap gray
%axis image
%axis off
drawnow
imshow(Reconstructed)
